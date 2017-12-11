//
//  QLCommunityViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/2.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import MJRefresh

let DynamicCellID = "QLDynamicCell"
let HotAndRecommendCellID = "QLHotAndRecommendCell"
let HeaderViewID = "QLCommunityHeaderView"
let SectionHeaderViewID = "QLSectionHeaderView"

enum CommunitySectionType: Int{
    case sectionIsHeader = 0 // 头
    case sectionIsBoutique   // 精品动态
    case sectionIsHot        // 热门话题
    case scetionIsArticle    // 推荐文章
    case sctionIsDynamicCell // 其他动态
}

class QLCommunityViewController: QLBaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var isHide: Bool = false
    var model: QLCommunityModel?
    var bannerImages: [String]?
    var lastDynamicID: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubViews()
        
        self.loadCommunityData()
    }
    
    // MARK: 获取接口数据
    private func loadCommunityData() {
        
        QLCommunityParser().loadCommunityData { (model) in
            self.model = model
            self.bannerImages = [String]()
            for bannerModel in (model?.ret?.banner)! {
                self.bannerImages?.append(bannerModel.img!)
            }
            self.collectionView.reloadData()
            self.collectionView.mj_footer.isHidden = ((self.model?.ret?.select_post?.count)! == 8)
            self.lastDynamicID = self.model?.ret?.select_post?.last?.id ?? ""
        }
    }
    
    @objc private func nextPageData() {
        
        QLCommunityParser().loadMoreData(self.lastDynamicID!) { (model) in
            self.collectionView.mj_footer.endRefreshing()
            if model?.ret?.select_post?.count == 0 {
                self.collectionView.mj_footer.isHidden = true
                return
            }
            self.model?.ret?.select_post! += (model?.ret?.select_post)!
            self.collectionView.reloadData()
            self.lastDynamicID = model?.ret?.select_post?.last?.id ?? ""
        }
    }
    
    // MARK: - buttonActions
    @IBAction func leftButtonAction(_ sender: UIButton) {
        
    }
    
    @objc private func cameraButtonAction() {
        print("打开相机")
    }

    // MARK: - initSubViews
    
    private func setSubViews() {
        self.collectionView.register(UINib.init(nibName: DynamicCellID, bundle: nil), forCellWithReuseIdentifier: DynamicCellID)
        self.collectionView.register(UINib.init(nibName: HotAndRecommendCellID, bundle: nil), forCellWithReuseIdentifier: HotAndRecommendCellID)
        self.collectionView.register(UINib.init(nibName: HeaderViewID, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        self.collectionView.register(UINib.init(nibName: SectionHeaderViewID, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SectionHeaderViewID)
        
        self.view.addSubview(self.cameraButton)
        self.cameraButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-70)
            make.height.width.equalTo(60)
        }
        
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(nextPageData))
        footer.setTitle("", for: .refreshing)
        self.collectionView.mj_footer = footer;
    }
  
    fileprivate func showCamerButton() {
        self.cameraButton.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-70)
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        isHide = false
    }
    
    fileprivate func hideCamerButton() {
        self.cameraButton.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(60)
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        isHide = true
    }
    
    lazy var cameraButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(#imageLiteral(resourceName: "CommunityPostBtn"), for: .normal)
        button.addTarget(self, action: #selector(cameraButtonAction), for: .touchUpInside)
        
        return button
    }()
}

// MARK: - UICollectionViewDataSource

extension QLCommunityViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch CommunitySectionType(rawValue: section)! {
        case .sectionIsHeader:
            return 0
            
        case .sectionIsBoutique:
            return (self.model?.ret?.rec_post?.count) ?? 4
            
        case .sectionIsHot, .scetionIsArticle:
            return 1
            
        default:
            return (self.model?.ret?.select_post?.count) ?? 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch CommunitySectionType(rawValue: indexPath.section)! {
        case .sectionIsHot, .scetionIsArticle:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotAndRecommendCellID, for: indexPath) as! QLHotAndRecommendCell
            cell.type = CommunitySectionType(rawValue: indexPath.section)!
            cell.modelList = self.model?.ret
            return cell;
            
        case .sectionIsBoutique:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DynamicCellID, for: indexPath) as! QLDynamicCell
            cell.model = self.model?.ret?.rec_post![indexPath.item]
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DynamicCellID, for: indexPath) as! QLDynamicCell
            cell.model = self.model?.ret?.select_post![indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch CommunitySectionType(rawValue: indexPath.section)! {
        case .sectionIsHeader:
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID, for: indexPath) as! QLCommunityHeaderView
            sectionHeaderView.bannerView.images =  self.bannerImages
            return sectionHeaderView
    
        default:
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SectionHeaderViewID, for: indexPath) as! QLSectionHeaderView
            sectionHeaderView.type = CommunitySectionType(rawValue: indexPath.section)!
            return sectionHeaderView
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension QLCommunityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch CommunitySectionType(rawValue: section)! {
        case .sectionIsHeader:
           return CGSize(width: SCREEN_WIDTH, height: 280)
            
        case .sctionIsDynamicCell:
             return CGSize(width: SCREEN_WIDTH, height: 10)
            
        default:
            return CGSize(width: SCREEN_WIDTH, height: 45)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch CommunitySectionType(rawValue: indexPath.section)! {
        case .sectionIsHeader:
            return CGSize(width: 0, height: 0)
            
        case .sectionIsHot, .scetionIsArticle:
            return CGSize(width: SCREEN_WIDTH - 20, height: 120)
            
        default:
            return CGSize(width: (SCREEN_WIDTH - 30)/2, height: 250)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let type = CommunitySectionType(rawValue: indexPath.section)
        if type == .sectionIsBoutique || type == .sctionIsDynamicCell {
            
            let dynamicDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "QLDynamicDetailViewController") as! QLDynamicDetailViewController
            dynamicDetailVC.hidesBottomBarWhenPushed = true
            if type == .sectionIsBoutique {
                dynamicDetailVC.pid = self.model?.ret?.rec_post![indexPath.item].id
            }
            else {
                dynamicDetailVC.pid = self.model?.ret?.select_post![indexPath.item].id
            }
            self.navigationController?.pushViewController(dynamicDetailVC, animated: true)
        }
    }
}

extension QLCommunityViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView).y
        
        if velocity > 0 && isHide {
            self.showCamerButton()
        }
        else if velocity < 0 && !isHide {
            self.hideCamerButton()
        }
    }
}


