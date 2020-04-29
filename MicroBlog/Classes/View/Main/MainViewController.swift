//
//  MainViewController.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit
import RTRootNavigationController

class MainViewController: UITabBarController {

    // MARK:监听方法
    // 点击撰写按钮
    @objc private func clickComposedButton() -> () {
        print("点击了")
    }
    
    
    // MARK: 视图生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewcontrollers()
        setupComposedButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.bringSubviewToFront(composedButton)
    }
    
    // MARK: 懒加载控件
    lazy private var composedButton: UIButton =
        UIButton.init(
        imageName: "tabbar_compose_icon_add",
        backImageName: "tabbar_compose_button")
}

// MARK: 设置界面
extension MainViewController {
    
    /// 添加撰写按钮
    private func setupComposedButton() {
        // 1.添加按钮
        tabBar.addSubview(composedButton)
        // 2.调整按钮
        let count = viewControllers!.count
        // 让按钮宽一点的，解决手指触摸的容错问题
        let w = tabBar.bounds.width / CGFloat(count) - 1
        composedButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        // 3.添加监听事件
        composedButton.addTarget(self, action: #selector(self.clickComposedButton), for: .touchUpInside)
    }
    
    /// 添加所有控制器
    private func addChildViewcontrollers() {

        // 设置 tintColor - 图片渲染颜色
        // 性能提升技巧 - 如果能用颜色解决，就建议用图片
        //tabBar.tintColor = .orange
        
        addChildViewController(vc: HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(vc: MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChild(UIViewController())
        addChildViewController(vc: DiscoveryTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(vc: ProfileTableViewController(), title: "个人", imageName: "tabbar_profile")
    }
    
    /// 添加子控制器
    /// - Parameters:
    ///   - vc: vc
    ///   - title: 标题
    ///   - imageName: 图像名称
    private func addChildViewController(vc: UIViewController, title: String, imageName: String) {
        
        // 设置标题
        vc.title = title
        
        //设置图像
        vc.tabBarItem.image = UIImage.init(named: imageName)
        
        // 导航控制器
        let nav = RTRootNavigationController.init(rootViewController: vc)
        
        addChild(nav)
    }
    
}
