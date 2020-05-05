//
//  WelcomeViewController.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/5.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    
    // 设置界面，视图的层次结构
    override func loadView() {
        // 直接使用背景图作为根视图，不用关心图像的缩放问题
        view = backImageView
        
        setupUI()
    }
    
    // 视图加载完成之后的后续处理，通常用来设置数据
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 异步加载用户头像
        iconView.sd_setImage(with: UserAccountViewModel.sharedUserAccount.avatarUrl, placeholderImage: UIImage.init(named: "avatar_default_big"))
    }
    
    // 视图已经显示，通常可以动画/键盘处理
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1. 更改约束 -> 改变位置
        // snp.updateConstraints 更新已经设置过的约束
        // multiplier 属性是只读属性，创建之后，不允许修改
        /**
         使用自动布局开发，有一个原则：
         - 所有‘使用约束’设置位置的控件，不要再设置‘frame’
         
         * 原因：自动布局系统会根据设置的约束，自动计算控件的 frame
         * 在 layoutSubviews 函数中设置 frame
         * 如果程序猿主动修改 frame，会引起 自动布局系统计算错误
         
         - 工作原理：当有一个运行循环启动，自动布局系统会 ‘收集’ 所有的约束变化
         - 在运行循环结束前，调用 layoutSubviews 函数 ‘统一’ 设置 frame
         - 如果希望某些约束提前更新，使用 ‘layoutIfNeeded’ 函数让自动布局系统提前更新收集到的约束变化
         */
        iconView.snp.updateConstraints { (make) in
            //make.bottom.equalTo(view).multipliedBy(0.3) - 这样写会报错
            make.bottom.equalTo(view).offset(-view.bounds.height + 250)
        }
        
        // 2. 动画
        welcomeLabel.alpha = 0
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: {
            
            // 修改所有‘可动画’属性 - 自动布局的动画
            self.view.layoutIfNeeded()
            
        }) { (_) in
            
            UIView.animate(withDuration: 0.8, animations: {
                self.welcomeLabel.alpha = 1
            }) { (_) in
                // 不推荐的写法
                // UIApplication.shared.keyWindow?.rootViewController = MainViewController()
                
                // 发送通知
                NotificationCenter.default.post(name: NSNotification.Name(LEESwitchRootViewControllerNotification), object: nil)
            }
            
        }
    }
    
    // MARK: 懒加载控件
    /// 背景图像
    private lazy var backImageView: UIImageView = UIImageView.init(imageName: "ad_background")
    /// 头像
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView.init(imageName: "avatar_default_big")
        // 设置圆角
        imageView.layer.cornerRadius = 45
        imageView.layer.masksToBounds = true
        return imageView
    }()
    /// 欢迎标签
    private lazy var welcomeLabel = UILabel.init(title: "欢迎回来", fontSize: 18)
}

// MARK: 设置界面
extension WelcomeViewController {
    
    private func setupUI() {
        
        // 1. 添加控件
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        // 2. 自动布局
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view).offset(-250)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(16)
        }
    }
    
}
