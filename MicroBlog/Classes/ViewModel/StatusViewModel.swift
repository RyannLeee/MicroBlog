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
    
    /// Cell 可重用标识符
    var cellID: String {
        return status.retweeted_status != nil ? StatusCellRetweetID : StatusCellNormalID
    }
    
    /// 缓存行高
    lazy var rowHeight: CGFloat = {
        
        // 1.定义 Cell
        var cell: StatusCell
        
        // 根据是否是转发微博，决定 cell 的创建
        if status.retweeted_status != nil {
            cell = StatusRetweetCell.init(style: .default, reuseIdentifier: StatusCellRetweetID)
        } else {
            cell = StatusNormalCell.init(style: .default, reuseIdentifier: StatusCellNormalID)
        }
        
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
    /// - 认证类型等级 -1:没有认证, 0:认证用户, 2,3,5:企业认证, 220 微博达人
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
    /// - 如果是原创微博，可以有图，可以没有图
    /// - 如果是转发微博，一定没有图，retweeted_status 中，可以有图，可以没有图
    /// - 一条微博，最多只有一个 pic_urls 数组
    var thumbnailUrls: [URL]?
    
    /// 转发微博文字
    var retweetText: String? {
        
        // 1.判断是否是转发微博，如果不是直接返回 nil
        guard let s = status.retweeted_status else {
            return nil
        }
        
        // 2. s 就是转发微博
        let text = "@" + (s.user?.screen_name ?? "") + ":" + (s.text ?? "")
        
        return text
    }
    
    
    /// 构造函数
    init(status: Status) {
        self.status = status
        
        // 根据模型，来生成缩略图的数组
        if let urls = status.retweeted_status?.pic_urls ?? status.pic_urls {
            // 创建缩略图数组
            thumbnailUrls = [URL]()
            
            // 遍历字典数组 -> 数组如果可选，不允许遍历，原因：数组是通过下标来检索数据
            for dict in urls {
                
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
