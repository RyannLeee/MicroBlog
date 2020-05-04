//
//  UserAccount.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/4.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import Foundation

/// 用户账户模型
class UserAccount: NSObject, NSCoding {
    
    /// 用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
    @objc var access_token: String?
    
    /// access_token的生命周期，单位是秒数。
    /// 一旦从服务器获得过期时间，立刻计算准确的日期
    @objc var expires_in: TimeInterval = 0 {
        didSet {
            // 计算过期日期
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    /// 过期日期
    @objc var expiresDate: Date?
    
    /// 授权用户的UID，本字段只是为了方便开发者，减少一次user/show接口调用而返回的，第三方应用不能用此字段作为用户登录状态的识别，只有access_token才是用户授权的唯一票据。
    @objc var uid: String?
    
    /// 用户昵称
    @objc var screen_name: String?
    
    /// 用户头像地址（大图），180×180像素
    @objc var avatar_large: String?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["access_token", "expires_in", "expiresDate", "uid", "screen_name", "avatar_large"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
    // MARK: ‘键值’用户信息归档和解档
    /// 归档 - 在把当前对象保存到磁盘前，将对象编码成二进制数据 - 跟网络的序列化概念很像
    /// - Parameter coder: 编码器
    func encode(with coder: NSCoder) {
        coder.encode(access_token, forKey: "access_token")
        coder.encode(expiresDate, forKey: "expiresDate")
        coder.encode(uid, forKey: "uid")
        coder.encode(screen_name, forKey: "screen_name")
        coder.encode(avatar_large, forKey: "avatar_large")
    }
    
    /// 解档 - 从磁盘加载二进制文件，转换成对象使用 - 跟网络的反序列化很像
    /// - Parameter coder: 解码器
    /// 返回值为当前对象
    /// ‘requiered’ - 没有继承性，所有的对象只能解档出当前的类对象
    required init?(coder: NSCoder) {
        access_token = coder.decodeObject(forKey: "access_token") as? String
        expiresDate = coder.decodeObject(forKey: "expiresDate") as? Date
        uid = coder.decodeObject(forKey: "uid") as? String
        screen_name = coder.decodeObject(forKey: "screen_name") as? String
        avatar_large = coder.decodeObject(forKey: "avatar_large") as? String
    }
}
