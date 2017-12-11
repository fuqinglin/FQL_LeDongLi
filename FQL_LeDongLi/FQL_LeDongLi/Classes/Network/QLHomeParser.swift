//
//  QLHomeParser.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/24.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit

class QLHomeParser: NSObject {
    
    // 获取计划列表数据
    func loadPlanListData(_ handler: @escaping (PlanModel?) -> Void) {
        
        let url = "http://walk.ledongli.cn/v2/rest/recruit/sku_category_list"
        
        QLNetwork.POST(url) { (responds) in
            guard let responds = responds else {
                handler(nil)
                return
            }
            if let model = PlanModel.deserialize(from: responds) {
                handler(model)
                
            }else {
                handler(nil)
            } 
        }
    }
    
    // 获取天气数据
    func loadWeatherData(_ handler: @escaping (WeatherModel?) -> Void) {
        
        let url = "http://walk.ledongli.cn/v2/rest/weather/get_weather"
        var parames = [String: Any]()
        parames["date"] = Int64(Date().timeIntervalSince1970)
        parames["lat"] = 22.62758629750928
        parames["lon"] = 114.147532573881
        
        QLNetwork.GET(url, parameters: parames, headers: nil) { (responds) in
            print("weather: ", responds)
            
            guard let responds = responds else {
                handler(nil)
                return
            }
            if let model = WeatherModel.deserialize(from: responds) {
                handler(model)
                
            }else {
                handler(nil)
            }
        }
    }

}
