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
    
    /// 缓存行高
    lazy var rowHeight: CGFloat = {
        // 1.Cell
        let cell = StatusCell.init(style: .default, reuseIdentifier: StatusCellNormalID)
        
        // 2.计算高度
        return cell.rowHeight(vm: self)
    }()
    
    /// 用户头像 URL
    var userProfileUrl: URL {
        URL.init(string: status.user?.profile_image_url ?? "")!
    }
    
    /// 用户默认头像
    var userDefaultIconImage: UIImage {
        UIImage.init(named: "avatar_default_big")!
    }
    
    /// 用户会员等级图标
    var userMemberImage: UIImage? {
        
        // 根据 mbrank 来生成图像
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank < 7 {
            return UIImage.init(named: "common_icon_membership_level\(status.user!.mbrank)")
        } else if mbrank == 7 {
            return UIImage.init(named: "common_icon_membership_level6")
        }
        return nil
    }
    
    /// 用户认证图标
    /// 认证类型等级 -1:没有认证, 0:认证用户, 2,3,5:企业认证, 220 微博达人
    var userVipImage: UIImage? {
        
        switch(status.user?.verified_type ?? -1) {
        case 0:
            return UIImage.init(named: "avatar_vip")
        case 2, 3, 5:
            return UIImage.init(named: "avatar_enterprise_vip")
        case 220:
            return UIImage.init(named: "avatar_grassroot")
        default:
            return nil
        }
        
    }
    
    /// 缩略图 URL 数组 - 存储型属性
    var thumbnailUrls: [URL]?
    
    
    /// 构造函数
    init(status: Status) {
        self.status = status
        
        // 根据模型，来生成缩略图的数组
        if status.pic_urls?.count ?? 0 > 0 {
            // 创建缩略图数组
            thumbnailUrls = [URL]()
            
            // 遍历字典数组 -> 数组如果可选，不允许遍历，原因：数组是通过下标来检索数据
            for dict in status.pic_urls! {
                
                // 因为字典是按 key 来取值，如果 key 错误，会返回 nil
                let url = URL.init(string: dict["thumbnail_pic"]!)
                
                thumbnailUrls?.append(url!)
            }
        }
    }
    
    /// 描述信息
    var description: String {
        "\n" + status.description + "\n配图数组 \((thumbnailUrls ?? []) as NSArray)"
    }
}
