//
//  QLHotAndRecommendCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/6.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

let TopicCellID = "QLTopicAndArticleCell"

class QLHotAndRecommendCell: UICollectionViewCell {
    
    var type = CommunitySectionType.sectionIsHot
    @IBOutlet weak var collectionView: UICollectionView!
    var modelList: QLCommunityModelList? {
        didSet {
            guard modelList != nil  else {
                return
            }
            self.collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.register(UINib.init(nibName:TopicCellID , bundle: nil), forCellWithReuseIdentifier: TopicCellID)
    }
}

extension QLHotAndRecommendCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == .sectionIsHot {
            return modelList?.rec_hashtag?.count ?? 0
        }
        return modelList?.rec_collect?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCellID, for: indexPath) as! QLTopicAndArticleCell
        if type == .sectionIsHot {
            cell.topicModel = self.modelList?.rec_hashtag?[indexPath.item]
        }
        else {
            cell.articleModel = self.modelList?.rec_collect?[indexPath.item]
        }
        return cell
    }
}

extension QLHotAndRecommendCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 220, height: 110)
    }
    
}





