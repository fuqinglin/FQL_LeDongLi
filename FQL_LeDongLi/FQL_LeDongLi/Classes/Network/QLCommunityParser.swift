
//
//  QLCommunityNetwork.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/13.
//  Copyright © 2017年 KingLin. All rights reserved.
//
import UIKit
import Alamofire
import HandyJSON

class QLCommunityParser: NSObject {
    
    var url: URLConvertible = "https://walk.ledongli.cn/rest/community/fetch_home_page/v3"
    private var paras: Parameters = [String: Any]()
    
    func loadCommunityData(_ hander: @escaping (QLCommunityModel?) -> Void) {
        
        QLNetwork.POST(url, parameters: paras, headers: nil) { (respons) in
            guard let respons = respons else {
                hander(nil)
                return
            }
            if let model = QLCommunityModel.deserialize(from: respons) {
                hander(model)
            }else {
                hander(nil)
            }
        }
    }
    
    func loadMoreData(_ startID: String, hander: @escaping(QLCommunityModel?) -> Void) {
        
        paras["start"] = startID
        paras["page"] = 10
        
        self.loadCommunityData(hander)
    }
}



