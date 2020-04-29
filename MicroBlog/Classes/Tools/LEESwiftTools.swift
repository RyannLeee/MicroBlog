//
//  LEESwiftTools.swift
//  UarmIntellect
//
//  Created by yuanlee on 2020/4/2.
//  Copyright © 2020 广州右岸信息技术有限公司. All rights reserved.
//

import UIKit
import Foundation

/// 全局颜色
public let GlobalColor = RGBColor(0x58D7B9)
/// 屏幕宽度
public let MainScreenWidth = UIScreen.main.bounds.width
/// 屏幕高度
public let MainScreenHeight = UIScreen.main.bounds.height

/// 中英文判断
public var languageIsEnglish: Bool {
    //let preferLang = NSLocale.preferredLanguages.first
    let preferLocal = Bundle.main.preferredLocalizations.first
    
    return !(preferLocal?.hasPrefix("zh-") ?? true)
}

// MARK: - 封装的日志输出功能（T表示不指定日志信息参数类型）

/// 为 Swift 封装的日志输出功能（T表示不指定日志信息参数类型)
/// - Parameter message: 要打印的内容
/// - Parameter file: 当前所在文件
/// - Parameter methodName: 当前位置的方法名
/// - Parameter lineNumber: 当前位置所在行数
public func NSLog<T>(_ message: T, file : String = #file, methodName: String = #function, lineNumber : Int = #line) {
    #if DEBUG

    ///去掉 .swift
    ///let filePath = file as NSString
    ///let filePath_copy = filePath.lastPathComponent as NSString
    ///let fileName = filePath_copy.deletingPathExtension
    
    //获取文件名
    ///带后缀 .swift
    let fileName = (file as NSString).lastPathComponent
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    // 为日期格式器设置格式字符串
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    // 使用日期格式器格式化当前日期、时间
    let datestr = dformatter.string(from: Date())
    //打印日志内容
    print("\(datestr)\n    文件:\(fileName)[第\(lineNumber)行]\n    方法:\(methodName)\n    打印:\(message)")
    #else
    #endif
}

// 通知相关

/// 为 Swift 封装的发送 Notification 的快捷方法
/// - Parameter name: 通知名称
/// - Parameter object: 通知对象
/// - Parameter userInfo: 通知内容
public func LEEPostNotification(_ name: String, _ object: Any? = nil, _ userInfo: [AnyHashable : Any]? = nil) {
    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: name), object: object, userInfo: userInfo)
}

/// 为 Swift 封装的添加 Notification Observer 的快捷方法
/// - Parameter observer: Observer 对象
/// - Parameter selector: 收到通知时执行的方法
/// - Parameter name: 要 Observer 的通知名称
/// - Parameter object: 通知对象
public func LEEAddNotificationObserver(_ observer: Any, _ selector: Selector, _ name: String, _ object: Any? = nil) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
}


/// 为 Swift 封装的移除 Notification Observer 的快捷方法
/// - Parameter observer: Observer
/// - Parameter name: Observer Name
/// - Parameter object: Observer Object
public func LEERemoveNotificationObserver(_ observer: Any, _ name: NSNotification.Name? = nil, _ object: Any? = nil) {
    NotificationCenter.default.removeObserver(observer, name: name, object: object)
}

/// 十六进制颜色
/// - Parameter rgb: 十六进制数字，如 0xFFFFFF
/// - Returns: UIColor
public func RGBColor(_ rgb: Int) -> UIColor {
    UIColor.init(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgb & 0xFF)) / 255.0, alpha: 1.0)
}

/// 十六进制颜色加 alpha 值
/// - Parameters:
///   - rgb: 十六进制数字，如 0xFFFFFF
///   - alpha: 透明度百分比，范围: 0 ~ 1.0
/// - Returns: UIColor
public func RGBAColor(_ rgb: Int, _ alpha: CGFloat) -> UIColor {
    UIColor.init(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgb & 0xFF)) / 255.0, alpha: alpha)
}

// 屏幕尺寸等

// iPhone X / iPhone XS
public var is_iPhoneX_XS: Bool {
    (MainScreenWidth == 375.0 && MainScreenHeight == 812.0) ? true : false
}

// iPhone XR / iPhone XS Max
public var is_iPhoneXR_XSMax: Bool {
    (MainScreenWidth == 414.0 && MainScreenHeight == 896.0) ? true : false
}

// iPhone 5s
public var is_iPhone5s: Bool {
    (MainScreenWidth == 320 && MainScreenHeight == 568) ? true : false
}

// 异形全面屏
public var isFullScreen: Bool {
    (is_iPhoneX_XS || is_iPhoneXR_XSMax) ? true : false
}

// Status bar height.
public var statusBarHeight: CGFloat {
    isFullScreen ? 44.0 : 20.0
}

// Navigation bar height.
public let navigationBarHeight: CGFloat = 44.0

// Tabbar height.
public var tabbarHeight: CGFloat {
    isFullScreen ? (49.0 + 34.0) : 49.0
}

// Tabbar safe bottom margin.
public var tabbarSafeBottomMargin: CGFloat {
    isFullScreen ? 34.0 : 0.0
}

// Status bar & navigation bar height.
public var statusBarAndNavigationBarHeight: CGFloat {
    isFullScreen ? 88.0 : 64.0
}

/// 字体大小
/// - Parameter size: 大小
/// - Returns: UIFont
public func SYSTEMFONT(_ size: CGFloat) -> UIFont {
    UIFont.systemFont(ofSize: size)
}

/// 加粗字体大小
/// - Parameter size: 大小
/// - Returns: UIFont
public func BOLDSYSTEMFONT(_ size: CGFloat) -> UIFont {
    UIFont.boldSystemFont(ofSize: size)
}

/// 简化多语言的获取
/// - Parameter key: key
/// - Returns: String
public func LocalizedString(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}

public var isIPad: Bool {
    // UIDevice.current.model 无法判断模拟器 iPad，所以改为以下方式
    (UI_USER_INTERFACE_IDIOM() == .pad) ? true : false
}

public var isIPhone: Bool {
    let string = UIDevice.current.model as NSString
    return (string.range(of: "iPhone").location != NSNotFound) ? true : false
}
