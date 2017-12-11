//
//  QLSegment.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/8.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

protocol QLSegmentDelegate {
    
    func scrollToSelectedIndex(index: Int)
}

class QLSegment: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titles: [String]? {
        didSet {
            guard titles != nil else {
                return
            }
            self.initSubViews()
        }
    }
    
    var previousButton: UIButton!
    var delegate: QLSegmentDelegate?
    
    private func initSubViews() {
        
        let width = self.bounds.size.width / CGFloat(titles!.count)
        let height = self.bounds.size.height
        for (index, title) in titles!.enumerated() {
            let button = UIButton.init(type: .custom)
            button.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: height)
            button.tag = index + 100
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(BASE_COLOR, for: .selected)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.addSubview(button)
            if index == 0 {
                button.isSelected = true
                previousButton = button
            }
        }
        
        let point = UIView.init(frame: CGRect(x: width / 2 - 4, y: height - 10, width: 8, height: 8))
        point.tag = 1010
        point.layer.cornerRadius = 4
        point.backgroundColor = BASE_COLOR
        self.addSubview(point)
    }
    
    @objc private func buttonAction(button: UIButton) {
        guard button != previousButton else {
            return
        }
        delegate?.scrollToSelectedIndex(index: button.tag - 100)
    }
    
    func scrollToIndex(_ index: CGFloat) {
        
        let point = self.viewWithTag(1010)
        let currentButton = self.viewWithTag(100 + Int(index)) as! UIButton
        let width = self.bounds.size.width / CGFloat(titles!.count)
        let height = self.bounds.size.height
        
        previousButton.isSelected = false
        currentButton.isSelected = true
        previousButton = currentButton
        
        UIView.animate(withDuration: 0.35) {
            
            point?.frame = CGRect(x: (width * index)+(width/2) - 4, y: height - 10, width: 8, height: 8)
        }
    }
}
