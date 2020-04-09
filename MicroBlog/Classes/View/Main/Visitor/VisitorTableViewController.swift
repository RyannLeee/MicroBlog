//
//  VisitorTableViewController.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

class VisitorTableViewController: UITableViewController {

    /// 用户登录标记
    private var userLogon = false
    
    /**
     1.应用程序中有几个 visitorView？- 每个控制器各自有各自不同的访客视图！
     2.访客视图如果用懒加载会怎样？ - 如果使用懒加载，访客视图始终都会被创建出来！
     */
    /// 访客视图
    var visitorView: VisitorView?
    

    override func loadView() {
        // 根据用户登录情况，决定显示的根视图
        userLogon ? super.loadView() : setupVisitorView()
    }
    
    /// 设置访客视图
    private func setupVisitorView() {
        // 替换根视图
        visitorView = VisitorView()
        view = visitorView
        
        // 添加监听方法
        visitorView?.registerButton.addTarget(self, action: #selector(self.visitorViewDidClickRegister), for: .touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(self.visitorViewDidClickLogin), for: .touchUpInside)
        
        // 设置导航栏按钮
        navigationItem.leftBarButtonItem = .init(title: "注册", style: .plain, target: self, action: #selector(self.visitorViewDidClickRegister))
        navigationItem.rightBarButtonItem = .init(title: "登录", style: .plain, target: self, action: #selector(self.visitorViewDidClickLogin))
    }
    
}

extension VisitorTableViewController {
    
    @objc private func visitorViewDidClickRegister() {
        NSLog("点击注册")
    }
    
    @objc private func visitorViewDidClickLogin() {
        NSLog("点击登录")
    }
    
}
