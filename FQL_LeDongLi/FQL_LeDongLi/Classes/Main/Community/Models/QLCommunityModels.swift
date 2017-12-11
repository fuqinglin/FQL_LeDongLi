//
//  QLCommunityModel.swift
//  FQL_LeDongLi
//
//  Created by Kinglin on 2017/11/14.
//  Copyright © 2017年 KingLin. All rights reserved.
//

import UIKit
import HandyJSON


class QLRespondModel: HandyJSON {
    
    var errorCode: Int?
    var isSuccess: Bool {
        get {
            if errorCode != 0 {return false}
            return true
        }
    }
    required init() {}
}

/*
 "ret": {
     "rec_post": [{
 */

class QLCommunityModel: QLRespondModel {
    var ret: QLCommunityModelList?
    required init() {}
}

/*
"ret": {
    "rec_post": [{
    "img_meta": [],
    "id": 3494519,
*/
class QLCommunityModelList: HandyJSON {
    var rec_post:    [DynamicModel]?
    var banner:      [BannerModel]?
    var select_post: [DynamicModel]?
    var rec_collect: [ArticleModel]?
    var rec_hashtag: [TopicModel]?
    
    required init() {}
}

/*
 "img_meta": [],
 "id": 3494519,
 "img": "http:\/\/cdn.ledongli.cn\/walker_post_img\/75001286\/1510551746011.jpg?x-oss-process=image\/quality,q_40",
 "like_cnt": 130,
 "like_status": 0,
 "img_proportion": 0.806424,
 "content": "臀冲要点：\r\n1、,
 "meta": {
 "dict": true
 },
 "comment_cnt": 17
 
 */
class DynamicModel: HandyJSON {
    
    var id: String?
    var img: String? = ""
    var like_cnt: String?
    var like_status: String?
    var img_proportion: String?
    var content: String?
    var comment_cnt: String?
    
    required init() {}
}

/*
 "link": "ledongliopen:\/\/jump?type=1&data=https:\/\/walk.ledongli.cn\/statics\/atenza\/",
 "title": "11.13-14 马自达1屏",
 "id": 325,
 "img": "http:\/\/cdn.ledongli.cn\/discovery\/5f51832e-eaca-4c16-8f4e-4dccd1402d1d.png",
 "ad1": {
 "c": "",
 "v": ""
 },
 "img_proportion": 1.77777
 */
class BannerModel: HandyJSON {
    var link: String?
    var title: String?
    var id: String?
    var img: String? = ""
    var img_proportion: String?
    
    required init() {}
}

/*
 "img": "http:\/\/cdn.ledongli.cn\/discovery\/624b82b3-03d0-450a-adda-304d0efd9a81.jpg",
 "title": "吃着吃着就瘦了",
 "id": 622
 */
class TopicModel: HandyJSON {
    var img: String? = ""
    var title: String?
    var id: String?
    
    required init() {}
}

/*
 "img": "http:\/\/cdn.ledongli.cn\/discovery\/893b546a-d0a6-45e1-980c-6b8b5926afe9.jpg",
 "title": "够稳才是老司机",
 "id": 2670
 */
class ArticleModel: HandyJSON {
    var img: String? = ""
    var title: String?
    var id: String?
    
    required init() {}
}


// MARK: 动态详情页Models

class DynamicDetailRet: QLRespondModel {
    var ret: DynamicDetailModel?
    
    required init() {}
}


class DynamicDetailModel: HandyJSON {
    var post_like: [UserModel]?
    var post_detail: PostDetailModel?
    
    required init() {}
}

/*
 "dict": true,
 "id": 3589824,
 "like_status": 0,
 "img_proportion": 0.75,
 "ctime": 1511085635,
 "author"：{}
 "select_comment_cnt": 0,
 "like_cnt": 71,
 "content": "广东突然降温 冷得不得了 😂#解锁健身freestyle##就要活出漂亮#",
 "title": "",
 "comment_cnt": 31,
 "type": 1,
 "favorite_status"：0
 "img": "http:\/\/cdn.ledongli.cn\/walker_post_img\/39A3DB03-0F94-4F26-8769-85CD48DC32D8.jpg"
 */
class PostDetailModel: HandyJSON {
    var dict: Bool?
    var id: String?
    var like_status: String?
    var img_proportion: String?
    var ctime: String?
    var author: UserModel?
    var select_comment_cnt: String?
    var like_cnt: String?
    var content: String?
    var title: String?
    var comment_cnt: String?
    var type: String?
    var favorite_status: String?
    var img: String = ""
    
    required init() {}
}

/*
 "uid": 46271630,
 "avatar": "https:\/\/ledongli-files-staging.oss-cn-hangzhou.aliyuncs.com\/avatar\/46271630-1504620336537.jpg",
 "nickname": "天天向上"
 */
class UserModel: HandyJSON {
    var uid: String?
    var avatar: String? = ""
    var nickname: String?
    
    required init() {}
}


class CommentRet: QLRespondModel {
    var ret: CommentModelList?
    
    required init() {}
}

class CommentModelList: HandyJSON {
    var comment: [CommentModel]?
    
    required init() {}
}

/*
 "like_status": 0,
 "content": "好羡慕嫉妒恨",
 "uid": 76386581,
 "id": 303988,
 "like_cnt": 0,
 "ctime": 1511140306,
 "aid": 0,
 "author": {
 "dict": true,
 "avatar": "https:\/\/ledongli-files-staging.oss-cn-hangzhou.aliyuncs.com\/avatar\/76386581-1511138806432.jpg",
 "uid": 76386581,
 "nickname": "陈国柱"
 }
 */
class CommentModel: HandyJSON {
    var like_status: String?
    var content: String?
    var uid: String?
    var id: String?
    var like_cnt: String?
    var ctime: String?
    var aid: String?
    var author: UserModel?
    
    required init() {}
}



