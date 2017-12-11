//
//  QLMyPageCell.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/9.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLMyPageCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var infoDic: [String: Any]? {
        didSet {
            guard let dic = infoDic else {
                return
            }
            myImageView.image = dic["image"] as! UIImage!
            titleLabel.text = dic["title"] as! String!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
