//
//  QLSectionHeaderView.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/3.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLSectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    var type: CommunitySectionType! {
        didSet {
            switch type {
            case .sectionIsBoutique:
                self.titleLabel.text = "精品动态"
            case .sectionIsHot:
                self.titleLabel.text = "热门话题"
            case .scetionIsArticle:
                self.titleLabel.text = "推荐文章"
            default:
                self.titleLabel.text = ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
