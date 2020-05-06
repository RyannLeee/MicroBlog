//
//  AppDelegate.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 测试归档的用户账号
        NSLog(UserAccountViewModel.sharedUserAccount.account)
        
        setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = defaultRootViewController
        window?.makeKeyAndVisible()
        
        // 监听通知
        addNotificationObserver(forName: LEESwitchRootViewControllerNotification) { [weak self] (notification) in
            NSLog(Thread.current)
            NSLog(notification)
            // 切换控制器
            let vc = notification.object != nil ? WelcomeViewController() : MainViewController()
            self?.window?.rootViewController = vc
        }
        
        return true
    }
    
    deinit {
        // 注销通知 - 注销指定的通知
        removeNotificationObserver(self, name: NSNotification.Name.init(LEESwitchRootViewControllerNotification))
    }
    
    private func setupAppearance() {
        //修改导航栏的全局外观 - 要在控件创建之前设置，一经设置全局有效
        UINavigationBar.appearance().tintColor = GlobalTintColor
        UITabBar.appearance().tintColor = GlobalTintColor
    }
}

// MARK: 界面切换代码
extension AppDelegate {
    
    /// 启动的根视图控制器
    private var defaultRootViewController: UIViewController {
        // 1.判断是否登录
        if UserAccountViewModel.sharedUserAccount.userLogon {
            return WelcomeViewController()
        }
        
        // 2.没有登录返回主控制器
        return MainViewController()
    }
    
    /// 判断是否新版本
    private var isNewVersion: Bool {
        
        // 1. 当前版本 - info.plist
        //print(Bundle.main.infoDictionary as Any)
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let version = Double(currentVersion)!
        NSLog("当前版本:\(version)")
        
        // 2. ‘之前版本’，把当前版本保存在用户偏好 - 如果 key 不存在，返回 0
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
        NSLog("之前版本:\(sandboxVersion)")
        
        // 3. 保存当前版本
        UserDefaults.standard.set(version, forKey: sandboxVersionKey)
        
        return version > sandboxVersion
    }
    
}
