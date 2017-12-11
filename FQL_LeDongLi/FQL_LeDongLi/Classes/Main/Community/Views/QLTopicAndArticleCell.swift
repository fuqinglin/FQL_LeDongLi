//
//  QLTopicAndArticleCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/6.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLTopicAndArticleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var topicModel: TopicModel? {
        didSet {
            guard let model = topicModel else {
                return
            }
            titleLabel.text = model.title
            imageView.kf.setImage(with: URL(string:model.img!))
        }
    }
    
    var articleModel: ArticleModel? {
        didSet {
            guard let model = articleModel else {
                return
            }
            titleLabel.text = model.title
            imageView.kf.setImage(with: URL(string:model.img!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
