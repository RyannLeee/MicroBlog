//
//  User.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 用户模型
class User: NSObject {

    /// 关注用户用户 id
    @objc var id: Int64 = 0
    
    /// 关注用户昵称
    @objc var screen_name: String?
    
    /// 关注用户头像地址
    @objc var profile_image_url: String?
    
    /// 认证类型等级  -1:没有认证, 0:认证用户, 2,3,5:企业认证, 220 微博达人
    @objc var verified_type: Int = -1
    
    /// 会员等级 1 - 6
    @objc var mbrank: Int = 0
    
    /// 重写 init 构造函数，目的：让 YYModel 使用
    override init() {
        super.init()
    }
    
    // KVC 方法初始化
//    init(dict: [String : Any]) {
//        super.init()
//
//        setValuesForKeys(dict)
//    }
    
    //override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        yy_modelDescription()
        //let keys = ["id", "screen_name", "profile_image_url", "verified_type", "mbrank"]
        //return dictionaryWithValues(forKeys: keys).description
    }
    
}
