//
//  Common.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/9.
//  Copyright © 2020 yuanlee. All rights reserved.
//


/// 目的：提供全局共享属性或者方法，类似于 OC 中的 pch 文件
import UIKit

// MARK: 全局通知定义
/// 切换根视图控制器通知 - 一定要够长，要有前缀
let LEESwitchRootViewControllerNotification = "LEESwitchRootViewControllerNotification"

/// 全局外观渲染颜色 -> 延展出皮肤的管理类
let GlobalTintColor = UIColor.orange
