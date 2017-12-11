//
//  QLPlanCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/8.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLPlanCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryModel: PlanCategory? {
        didSet {
            guard let model = categoryModel else {
                return
            }
            self.imageView.kf.setImage(with: URL(string: model.img_url!))
        }
    }
    
    private func initSubViews() {
        
        imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.orange
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            
            make.top.left.bottom.right.equalToSuperview()
        }
        
    }
}
