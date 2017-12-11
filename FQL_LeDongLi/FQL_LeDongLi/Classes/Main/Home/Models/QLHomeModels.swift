//
//  QLHomeModels.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/24.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import HandyJSON

class PlanModel: QLRespondModel {
    var ret: PlanList?
    
    required init() {}
}

class PlanList: HandyJSON {
    var sku_category_list: [PlanCategory]?
    
    required init() {}
}

/*
 "link_url": "https://splan.ledongli.cn/index_jz_newuser.html",
 "img_url": "http://cdn.ledongli.cn/cdn-uploader/_1496820227621/2.png",
 "name": "零基础减脂"
 */

class PlanCategory: HandyJSON {
    
    var link_url: String? = ""
    var img_url: String? = ""
    var name: String? = ""
    
    required init() {}
}


/*
 {"errorCode": 0,
 "ret": {
 "city_name": "深圳",
 "temperature": 19,
 "quality": "优",
 "aqi": 48,
 "min_temperature": 15,
 "max_temperature": 19,
 "weather_code": 4,
 "condition": "多云"}
 */

class WeatherModel: QLRespondModel {
    var ret: Weather?
    
    required init() {}
}

class Weather: HandyJSON {
    var city_name: String? = " "
    var temperature: String? = " "
    var quality: String? = " "
    var aqi: String? = " "
    var min_temperature: String? = " "
    var max_temperature: String? = " "
    var weather_code: String? = " "
    var condition: String? = " "
    
    required init() {}
}

