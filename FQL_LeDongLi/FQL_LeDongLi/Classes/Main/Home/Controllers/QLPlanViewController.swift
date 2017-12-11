//
//  QLPlanViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/8.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

let PlanCellID = "QLPlanCell"

class QLPlanViewController: QLBaseViewController {

    var planModelList: [PlanCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollctionView()
        self.loadPlanListData()
    } 
    
    // MARK: - 获取计划数据
    func loadPlanListData() {
        QLHomeParser().loadPlanListData { (model) in
            guard let models = model?.ret?.sku_category_list else {
                return
            }
            self.planModelList = models
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - initSubViews
    private func setCollctionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView.register(QLPlanCell.self, forCellWithReuseIdentifier: PlanCellID)   
    }
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: SCREEN_WIDTH - 20, height: 150)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(), collectionViewLayout:self.flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
}

extension QLPlanViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.planModelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanCellID, for: indexPath) as! QLPlanCell
        cell.categoryModel = self.planModelList?[indexPath.item]
        return cell
    }
}

extension QLPlanViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}



