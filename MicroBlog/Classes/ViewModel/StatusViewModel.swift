//
//  StatusViewModel.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 微博视图模型 - 处理单条微博的业务逻辑
class StatusViweModel: CustomStringConvertible {
    
    /// 微博的模型
    var status: Status
    
    /// 用户头像 URL
    var userProfileUrl: URL {
        URL.init(string: status.user?.profile_image_url ?? "")!
    }
    
    /// 用户默认头像
    var userDefaultIconImage: UIImage {
        UIImage.init(named: "avatar_default_big")!
    }
    
    /// 用户会员图标
    var userMemberImage: UIImage? {
        
        // 根据 mbrank 来生成图像
        if status.user?.mbrank ?? 0 > 0 && status.user?.mbrank ?? 0 < 7 {
            return UIImage.init(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    /// 用户认证图标
    /// 认证类型等级 -1:没有认证, 0:认证用户, 2,3,5:企业认证, 220 微博达人
    var userVipImage: UIImage? {
        
        switch(status.user?.verified_type ?? -1) {
        case 0: return UIImage.init(named: "avatar_vip")
        case 2, 3, 5: return UIImage.init(named: "avatar_enterprise_vip")
        case 220: return UIImage.init(named: "avatar_grassroot")
        default:
            return nil
        }
        
    }
    
    /// 构造函数
    init(status: Status) {
        self.status = status
    }
    
    /// 描述信息
    var description: String {
        status.description
    }
}
