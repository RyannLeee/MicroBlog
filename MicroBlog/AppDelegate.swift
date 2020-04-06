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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

