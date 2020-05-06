//
//  Status.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 微博数据模型
class Status: NSObject {
    
    /// 微博ID
    @objc var id: Int64 = 0
    /// 微博信息内容
    @objc var text: String?
    /// 微博来源
    @objc var source: String?
    /// 微博创建时间
    @objc var created_at: String?
    /// 缩略图配图数组 key: thumbnail_pic
    @objc var pic_urls: [[String : String]]?
    /// 用户模型
    @objc var user: User?
    
    init(dict: [String : Any]) {
        super.init()
        
        // 如果使用 KVC 时，value 是一个字典，会直接给属性转换成字典
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        // 判断 key 是否是 user
        if key == "user" {
            if let dict = value as? [String : Any] {
                user = User.init(dict: dict)
            }
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["id", "text", "source", "created_at", "user", "pic_urls"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
