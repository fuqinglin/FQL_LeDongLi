//
//  QLTodayViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/8.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLTodayViewController: QLBaseViewController {
    
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubViews()
        self.loadWeatherData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 0, section: 0)
        let motionCell = self.collectionView.cellForItem(at: indexPath) as! QLRunningDataCell
        motionCell.refreshMotionValues()
    }
    
    // MARK: - 获取天气数据
    
    private func loadWeatherData() {
        
        QLHomeParser().loadWeatherData { (model) in
            guard let weather = model?.ret else {
                return
            }
            self.weatherModel = weather
            self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
        }
    }
    
    // MARK: - initSubView
    
    private func setSubViews() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView.register(UINib.init(nibName: RunningDataCellID, bundle: nil), forCellWithReuseIdentifier: RunningDataCellID)
        self.collectionView.register(UINib.init(nibName: DietCellID, bundle: nil), forCellWithReuseIdentifier: DietCellID)
        self.collectionView.register(UINib.init(nibName: AdCellID, bundle: nil), forCellWithReuseIdentifier: AdCellID)
    }
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(), collectionViewLayout:self.flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
}

extension QLTodayViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = ""
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RunningDataCellID, for: indexPath) as! QLRunningDataCell
            cell.weatherModel = self.weatherModel
            cell.delegate = self
            return cell

        case 1:
            cellIdentifier = DietCellID
            
        default:
            cellIdentifier = AdCellID
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
}

extension QLTodayViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.row {
        case 0:
            return CGSize(width: SCREEN_WIDTH - 20, height: 300 )
            
        case 1:
            return CGSize(width: SCREEN_WIDTH - 20, height: 100 )
            
        default:
            return CGSize(width: SCREEN_WIDTH - 20, height: 160 )
        }
    }
}

// MARK: - RunningDataCellDalegate
extension QLTodayViewController: RunningDataCellDalegate {
    func sportsTraining() {
        
    }
    
    func runningRecord() {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let runningRecordVC = stroyboard.instantiateViewController(withIdentifier: "QLRunningRecordViewController")
        runningRecordVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(runningRecordVC, animated: true)
    }
}

