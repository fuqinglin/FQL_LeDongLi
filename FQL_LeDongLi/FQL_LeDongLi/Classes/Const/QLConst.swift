//
//  QLConst.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/3.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import Kingfisher

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

// 基本色
let BASE_COLOR = UIColor.init(red: 253/255.0, green: 104/255.0, blue: 48/255.0, alpha: 1)

func RGB(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func ActiveEnergyBurned(_ distance: Double) -> Double {
    
    let weight = 50.0  // 体重需要采集，这里是默认值
    let k = 1.036      // 跑步消耗的系数
    return distance * weight * k  // 卡路里消耗计算公式：距离 * 体重 * 系数  (这个公式只是粗略计算)
}
