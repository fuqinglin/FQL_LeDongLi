//
//  QLCommentCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/17.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLCommentCell: UICollectionViewCell {
    
    @IBOutlet weak var cUserImageView: UIImageView!
    @IBOutlet weak var cNikeNameLabel: UILabel!
    @IBOutlet weak var cDateLable: UILabel!
    @IBOutlet weak var cLikesButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    var commentModel: CommentModel? {
        didSet {
            guard let model = commentModel else {
                return
            }
            cUserImageView.kf.setImage(with: URL(string:(model.author?.avatar)!))
            cNikeNameLabel.text = model.author?.nickname
            cDateLable.text = model.ctime
            cLikesButton.setTitle(model.like_cnt, for: .normal)
            commentLabel.text = model.content
        }
    }
    
    @IBAction func commentButtonAction(_ sender: UIButton) {
        
        
    }
}
