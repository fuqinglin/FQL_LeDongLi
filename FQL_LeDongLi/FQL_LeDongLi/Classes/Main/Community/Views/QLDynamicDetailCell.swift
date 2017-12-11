//
//  QLDynamicDetailCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/17.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLDynamicDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nikeNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dynamicImageView: UIImageView!
    
    var detailModel: PostDetailModel? {
        didSet {
            guard let model = detailModel else {
                return
            }
            userImageView.kf.setImage(with: URL(string:model.author!.avatar!))
            nikeNameLabel.text = model.author?.nickname
            dataLabel.text = model.ctime
            contentLabel.text = model.content
            dynamicImageView.kf.setImage(with: URL(string:model.img))
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        
    }
    
    
}
