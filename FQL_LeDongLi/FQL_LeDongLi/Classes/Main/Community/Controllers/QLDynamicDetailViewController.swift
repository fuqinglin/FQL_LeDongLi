//
//  QLDynamicDetailViewController.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/16.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import MJRefresh

class QLDynamicDetailViewController: QLBaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dynamicModel: DynamicDetailRet?
    var dynamicCommentModel: CommentRet?
    var commentModels = [CommentModel]()
    var pid: String?
    var startID: String? = "2147483647"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionView()
        self.loadDynamicDetailData()
        self.loadDynamicCommentsData()
    }
    
    private func setCollectionView() {
        let footer = MJRefreshAutoNormalFooter()
        footer.setTitle("", for: .refreshing)
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadDynamicCommentsData))
        footer.isHidden = true
        self.collectionView.mj_footer = footer
    }
    
    // MARK: 获取动态详情和动态所有评论数据
    private func loadDynamicDetailData() {
 
        QLDynamicDetailParser().loadDynamicDetailData(self.pid) { (model) in
            self.dynamicModel = model
            self.collectionView.reloadData()
        }
    }
    
    @objc private func loadDynamicCommentsData() {
        
        QLDynamicDetailParser().loadDynamicCommentsData(startID: self.startID, pID: self.pid) { (model) in
            if model?.ret?.comment == nil {return}
            
            if model?.ret?.comment?.count == 10 {
                self.startID = model?.ret?.comment?.last?.id
                self.collectionView.mj_footer.isHidden = false
                
            }else {
                self.collectionView.mj_footer.isHidden = true
            }
            self.dynamicCommentModel = model
            self.commentModels += (model?.ret?.comment)!
            self.collectionView.mj_footer.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension QLDynamicDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
            
        default:
            return self.commentModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QLDynamicDetailCell", for: indexPath) as! QLDynamicDetailCell
            cell.detailModel = self.dynamicModel?.ret?.post_detail
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QLLikeUsersCell", for: indexPath) as! QLLikeUsersCell
            cell.likeModel = self.dynamicModel?.ret
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QLCommentCell", for: indexPath) as! QLCommentCell
            cell.commentModel = self.commentModels[indexPath.item]
            return cell
        }
    }
}

extension QLDynamicDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: SCREEN_WIDTH, height: 500)
            
        case 1:
            return CGSize(width: SCREEN_WIDTH, height: 60)
            
        default:
            return CGSize(width: SCREEN_WIDTH, height: 100)
        }
    }
}




