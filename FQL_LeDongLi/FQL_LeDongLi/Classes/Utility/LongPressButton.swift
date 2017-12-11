//
//  LongPressButton.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/28.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class LongPressButton: UIButton {
    
    // 长按动画结束
    var longPressCompletion: ((_ completion: Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initButton()
    }
    
    private func initButton() {
        self.layer.addSublayer(self.animationLayer)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        longPress.minimumPressDuration = 0
        self.addGestureRecognizer(longPress)
        
    }

    @objc private func longPressAction(_ longPress: UILongPressGestureRecognizer) {
        
        switch longPress.state {
        case .began:
            self.beganAnimation()
            
        case .ended:
            self.endAnimation()
            
        case .cancelled:
            print("cancelled")
            
        default:
            print("faild")
        }
    }
    
    func beganAnimation() {
        
        self.beginLongPressAnimation()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.transform = .init(scaleX: 0.7, y: 0.7)
            
        }) { (finish) in
            
        }
    }
    
    func endAnimation() {
        self.endLongPressAnimation()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.transform = .identity
            
        }) { (finish) in
            
        }
    }
    
    func beginLongPressAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.delegate = self
        
        self.animationLayer.add(animation, forKey: "animation")
    }
    
    func endLongPressAnimation() {
        self.animationLayer.removeAllAnimations()
    }
    
    
    lazy var animationLayer: CAShapeLayer = {
        let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        let path = UIBezierPath(arcCenter: center, radius: self.bounds.size.width/2 - 5, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi*3/2, clockwise: true)
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = path.cgPath
        layer.lineWidth = 10
        layer.lineJoin = kCALineJoinRound
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = RGB(r: 251, g: 56, b: 65, a: 0.2).cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 0
        
        return layer
    }()

}

extension LongPressButton: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            print("animation finish")
            
            if (self.longPressCompletion != nil) {
                self.longPressCompletion!(flag)
            }
        }
    }
}



