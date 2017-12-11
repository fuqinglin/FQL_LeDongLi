//
//  QLMotionCircularView.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/23.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLMotionCircularView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    var currentPercent: CGFloat = 0
    var displayLink: CADisplayLink?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initSubViews()
    }
    
    func initSubViews() {
        self.addSubview(self.bgView)
        self.addSubview(self.bgCenterView)
        self.addSubview(self.percentLabel)
        self.layer.addSublayer(self.gradientLayer)
        
        self.bgView.snp.makeConstraints { (make) in
            make.centerWithinMargins.equalToSuperview().offset
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        self.bgCenterView.snp.makeConstraints { (make) in
            make.centerWithinMargins.equalToSuperview().offset
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        self.percentLabel.snp.makeConstraints { (make) in
            make.centerWithinMargins.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(150)
        }
        
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        view.layer.cornerRadius = 60
        
        return view
    }()

    lazy var bgCenterView: UIImageView = {
        let centerView = UIImageView(image: #imageLiteral(resourceName: "HomePageCircleCenter"))
        
        return centerView
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "100%"
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var circularLayer: CAShapeLayer = {

        let path = UIBezierPath(arcCenter: self.center, radius: 52, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi*(3/2.0), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: -15, y: -15, width: self.bounds.size.width - 30, height: self.bounds.size.height - 30)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 15
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        return shapeLayer
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 15, y: 15, width: self.bounds.size.width - 30, height: self.bounds.size.height - 30)
        layer.colors = [RGB(r: 66, g: 219, b: 195, a: 1).cgColor,
                        RGB(r: 59, g: 148, b: 211, a: 1).cgColor,
                        RGB(r: 229, g: 176, b: 59, a: 1).cgColor,
                        RGB(r: 176, g: 51, b: 111, a: 1).cgColor]
        layer.locations = [0.2, 0.4, 0.7, 1.0]
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        layer.mask = self.circularLayer
        return layer
    }()
    
    // 启动动画
    func startAnimation(_ percent: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.isRemovedOnCompletion = false
        animation.duration = 1.0
        animation.fillMode = kCAFillModeForwards
        animation.fromValue = 0
        animation.toValue = percent
        self.circularLayer.add(animation, forKey: "animation")
    }
    
    // 更新百分比的数值
    func refreshPercent(_ percent: CGFloat) {
        self.currentPercent = percent
        self.displayLink = CADisplayLink(target: self, selector: #selector(updatePercent))
        self.displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    var varPercent: CGFloat = 0
    @objc func updatePercent() {
        varPercent += 0.005
        self.percentLabel.text = String(format: "%.f%%", varPercent * 100.0)
        if varPercent >= self.currentPercent {
            self.displayLink?.invalidate()
            self.displayLink = nil
            varPercent = 0
        }
    }
}
