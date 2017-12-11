//
//  QLDynamicCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/3.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLDynamicCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeValue: UIButton!
    @IBOutlet weak var commentValue: UIButton!
    
    var model: DynamicModel? {
        didSet {
            guard let model = model else {
                return
            }
            self.imageView.kf.setImage(with:URL(string: model.img!))
            self.contentLabel.text = model.content
            self.likeValue.setTitle(model.like_cnt, for: .normal)
            self.commentValue.setTitle(model.comment_cnt, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

}
