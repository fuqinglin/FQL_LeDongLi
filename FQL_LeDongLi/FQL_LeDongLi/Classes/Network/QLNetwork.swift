//
//  QLNetwork.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/13.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import Alamofire

class QLNetwork: NSObject {
    
    static func POST (
        _ url: URLConvertible,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completionHandler: @escaping (String?) ->Void ) {
        
        var parames = parameters ?? [String: Any]()
        parames["uid"] = "76064015"
        parames["pc"] = "uuidb0310bf214420280e78a4eeadd33e9ee9203aac8"
        parames["v"] = "8.3.5 ios"
        parames["vc"] = "844 ios"
        parames["systemV"] = "11.0.2"
        parames["device"] = "iPhone7,2"

        Alamofire.request(url, method: .post, parameters: parames, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in

            switch response.result.isSuccess {
                
            case true:
                if let data = response.data {
                    
                    let jsonString = String.init(data: data, encoding: String.Encoding.utf8)
                    completionHandler(jsonString)
                    
                } else {
                    completionHandler(nil)
                }
                
            case false:
                print("------",response.error.debugDescription)
            }
        }
    }
    
    
    static func GET(_ url:URLConvertible,
                    parameters: Parameters? = nil,
                    headers: HTTPHeaders? = nil,
                    completionHandler: @escaping (String?) ->Void ) {
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result.isSuccess {
                
            case true:
                if let data = response.data {
                    let jsonString = String(data: data, encoding: String.Encoding.utf8)
                    completionHandler(jsonString)
                    
                }else {
                    completionHandler(nil)
                }
                
            case false:
                print(response.error.debugDescription)
            }
        }
    }
}
