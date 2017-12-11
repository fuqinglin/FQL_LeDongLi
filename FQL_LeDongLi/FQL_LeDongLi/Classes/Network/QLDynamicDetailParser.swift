//
//  QLCommunityDetailParser.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/20.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class QLDynamicDetailParser: NSObject {
    
    /// 获取动态详情数据
    ///
    /// - Parameters:
    ///   - pID: 动态的ID
    ///   - hander: 获取成功后回调操作
    func loadDynamicDetailData(_ pID: String?, hander: @escaping (DynamicDetailRet?) -> Void) {
        let url: URLConvertible = "https://walk.ledongli.cn/rest/community/fetch_post_detail_page/v3"
        let params: Parameters = ["pid": pID ?? ""]
        
        QLNetwork.POST(url, parameters: params , headers: nil) { (respondObjet) in
            
            guard let responds = respondObjet else {
                hander(nil)
                return
            }
            if let model = DynamicDetailRet.deserialize(from: responds) {
                hander(model)
            }else {
                hander(nil)
            }
        }
    }
    
    /// 获取动态的所有评论
    ///
    /// - Parameters:
    ///   - startID: 评论的起始ID
    ///   - pID: 动态的ID
    ///   - hander: 获取成功后的回调操作
    func loadDynamicCommentsData(startID: String?, pID: String?, hander: @escaping (CommentRet?) -> Void) {
        
        let url: URLConvertible = "https://walk.ledongli.cn/rest/community/fetch_comment/v3"
        var params: Parameters = [String: Any]()
        params["start"] = startID
        params["pid"] = pID
        params["page"] = "10"
        
        QLNetwork.POST(url, parameters: params, headers: nil) { (respondObject) in
            guard let responds = respondObject else {
                hander(nil)
                return
            }
            if let model = CommentRet.deserialize(from: responds) {
                hander(model)
            }else {
                hander(nil)
            }
        }
    }
}
