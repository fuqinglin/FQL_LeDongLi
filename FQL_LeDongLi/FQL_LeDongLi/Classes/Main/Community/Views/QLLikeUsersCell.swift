//
//  QLLikeUsersCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/17.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLLikeUsersCell: UICollectionViewCell {
    
    @IBOutlet weak var likeValueButton: UIButton!
    
    var likeModel: DynamicDetailModel? {
        didSet {
            guard let model = likeModel else {
                return
            }
            likeValueButton.setTitle(model.post_detail?.like_cnt, for: .normal)
            self.setUserImages(likeModel?.post_like)
        }
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    private func setUserImages(_ models:[UserModel]?) {
        guard let userModels = models else {
            return
        }
        for (index, userModel) in userModels.enumerated() {
            if index > 7 {return}
            
            let subView = self.contentView.subviews[index]
            if subView is UIImageView {
                let imageView = subView as! UIImageView
                imageView.isHidden = false
                imageView.kf.setImage(with: URL(string:userModel.avatar!))
            }
        }
    }
}







