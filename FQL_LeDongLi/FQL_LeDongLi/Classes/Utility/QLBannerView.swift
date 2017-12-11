//
//  QLBannerView.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/6.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import SnapKit

class BannerCell: UICollectionViewCell {
    
    var imageURL: String? {
        didSet {
            guard let imageURL = imageURL else {
                return
            }
            self.imageView.kf.setImage(with: URL(string: imageURL))
        }
    }
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView.init(frame: self.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class QLBannerView: UIView {
    
    var currentPage: Int = 0
    var autoTimeInterval: TimeInterval = 3
    
    var images: [String]? {
        didSet {
            print(images)
            guard let images = images else {
                return
            }
            self.initSubviews()
            self.pageControl.numberOfPages = images.count
            self.startTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    fileprivate func reloadImages() {
        
        if currentPage == 0 {
            currentPage = images!.count
            let indexPath = IndexPath.init(item: currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        else if currentPage == images!.count * 2 - 1 {
            currentPage = images!.count - 1
            let indexPath = IndexPath.init(item: currentPage , section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    // MARK: - timer自动滚动
    
    lazy var timer: Timer? = {
        
        let timer: Timer
        if #available(iOS 10.0, *) {
            timer = Timer.init(timeInterval: self.autoTimeInterval, repeats: true, block: { (timer) in
                self.nextPage()
            })
        }
        else {
            timer = Timer.scheduledTimer(timeInterval: self.autoTimeInterval, target: self, selector: #selector(QLBannerView.nextPage), userInfo: nil, repeats: true)
        }
        RunLoop.current.add(timer, forMode: .commonModes)
        
        return timer
    }()
    
    fileprivate func stopTimer() {
        self.timer?.fireDate = Date.distantFuture
    }
    
    fileprivate func startTimer() {
        self.timer?.fireDate = Date.init(timeIntervalSinceNow: self.autoTimeInterval)
    }
    
    @objc private func nextPage() {
        
        if currentPage == images!.count * 2 - 1 {
            self.reloadImages()
        }
        currentPage += 1
        self.pageControl.currentPage = currentPage % images!.count
        let indexPath = IndexPath.init(item: currentPage, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - initSubviews
    
    private func initSubviews() {
        self.collectionView.register(BannerCell.self, forCellWithReuseIdentifier:"BannerCell")
        self.addSubview(self.collectionView)
        self.addSubview(self.pageControl)
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        self.pageControl.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
        
        let indexPath = IndexPath.init(item: images!.count, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    private lazy var collectionView: UICollectionView = {
       
        let collection = UICollectionView.init(frame: CGRect(), collectionViewLayout: self.flowLayout)
        collection.dataSource = self
        collection.delegate = self
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false

        return collection
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        return layout
    }()
    
    private lazy var pageControl: UIPageControl = {
       
        let control = UIPageControl.init()
        control.numberOfPages = 0
        control.currentPageIndicatorTintColor = UIColor.white
        control.pageIndicatorTintColor = UIColor.init(white: 1, alpha: 0.5)

        return control
    }()
}

// MARK: - UICollectionViewDataSource

extension QLBannerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images!.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.imageURL = images?[indexPath.item % images!.count]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension QLBannerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.bounds.size.width, height: self.bounds.size.height)
    }
}

// MARK: - UIScrollViewDelegate

extension QLBannerView: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / SCREEN_WIDTH
        currentPage = Int(index)
        self.pageControl.currentPage = currentPage % images!.count
        
        self.reloadImages()
    }
}


