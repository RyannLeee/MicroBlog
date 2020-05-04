//
//  VisitorView.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit
import SnapKit

/// 访客视图，用户未登录时显示的界面
class VisitorView: UIView {
    
    // MARK: 设置视图信息
    /// 设置视图信息
    /// - Parameters:
    ///   - imageName: 图片名称，首页设置为 nil
    ///   - title: 消息文字
    func setupInfo(imageName: String?, title: String) {
        messageLabel.text = title
        
        guard let imgName = imageName else {
            // 播放动画
            startAnimation()
            
            return
        }
        
        iconView.image = UIImage.init(named: imgName)
        // 隐藏小房子
        homeIconView.isHidden = true
        // 将遮罩图像移至底层
        sendSubviewToBack(maskIconView)
    }
    
    /// 开启首页转轮动画
    private func startAnimation() {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation")
        animation.toValue = 2 * Double.pi
        animation.repeatCount = MAXFLOAT
        animation.duration = 20
        
        // 用在不断重复的动画，当动画绑定的图层对应的视图被销毁，动画会被销毁
        animation.isRemovedOnCompletion = false
        
        // 添加到图层
        iconView.layer.add(animation, forKey: nil)
    }
    
    // MARK: 构造函数
    // initWithFrame 是 UIView 的指定构造函数
    // 使用纯代码开发的入口
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    // initWithCoder 是 SB & XIB 开发加载的函数
    // 使用 SB 开发的入口
    required init?(coder: NSCoder) {
        // 阻止 SB 使用当前自定义视图
        // 如果只希望当前视图被纯代码的方式加载，可以使用 fatalError
        // 导致如果使用 SB 开发，调用这个视图，会直接崩溃
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        
        setupUI()
    }
    
    // MARK: 懒加载控件
    /// 图标，使用 image: 构造函数创建的 imageView 默认就是 image 的大小
    private lazy var iconView: UIImageView = .init(imageName: "visitordiscover_feed_image_smallicon")
    /// 遮罩图像
    private lazy var maskIconView: UIImageView = .init(imageName: "visitordiscover_feed_mask_smallicon")
    /// 小房子
    private lazy var homeIconView: UIImageView = .init(imageName: "visitordiscover_feed_image_house")
    /// 消息文字
    private lazy var messageLabel: UILabel = .init(title: "关注一些人，回这里看看有什么惊喜")

    /// 注册按钮
    lazy var registerButton: UIButton = .init(title: "注册", titleColor: .darkGray, backImageName: "common_button_white_disable")

    /// 登录按钮
    lazy var loginButton: UIButton = .init(title: "登录", titleColor: .darkGray, backImageName: "common_button_white_disable")

}

extension VisitorView {
    
    /// 设置界面
    private func setupUI() {
        
        // a.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // b.设置自动布局
        // 1.图标
        // make 理解为要添加的约束对象
        iconView.snp.makeConstraints { (make) in
            // 指定 centerX 属性 等于 ‘参照对象’
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-60)
        }
        // 2.小房子
        homeIconView.snp.makeConstraints { (make) in
            make.center.equalTo(iconView)
        }
        // 3.消息文字
        messageLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(16)
            make.width.equalTo(224)
            make.height.equalTo(36)
        }
        // 4.注册按钮
        registerButton.snp.makeConstraints { (make) in
            make.left.equalTo(messageLabel.snp.left)
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        // 5.登录按钮
        loginButton.snp.makeConstraints { (make) in
            make.right.equalTo(messageLabel.snp.right)
            make.top.equalTo(registerButton)
            make.width.equalTo(registerButton)
            make.height.equalTo(registerButton)
        }
        // 6.遮罩图像
        maskIconView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(registerButton)
        }
        
        // 设置背景颜色 - 灰度图 R = G = B, 在 UI 元素中，大多数都使用灰度图，或者纯色图（安全色）
        backgroundColor = .init(white: 237.0 / 255.0, alpha: 1.0)
        
        /*
         /**
          - 添加约束需要添加到父视图上
          - 子视图最好有一个统一的参照物
          */
         // translatesAutoresizingMaskIntoConstraints 的默认值是 true，支持使用 setFrame 的方式设置位置
         // false - 支持使用自动布局来设置控件位置
         
         for v in subviews {
             v.translatesAutoresizingMaskIntoConstraints = false
         }
        // 1.图标
        addConstraint(NSLayoutConstraint.init(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        // 2.小房子
        addConstraint(NSLayoutConstraint.init(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        // 3.消息文字
        addConstraint(NSLayoutConstraint.init(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint.init(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
        addConstraint(NSLayoutConstraint.init(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        // 4.注册按钮
        addConstraint(.init(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(.init(item: registerButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(.init(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(.init(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        // 5.登录按钮
        addConstraint(.init(item: loginButton, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(.init(item: loginButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(.init(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(.init(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        // 6.遮罩图像
        /**
         VFL : 可视化格式语言
         
         H 水平方向
         V 垂直方向
         | 边界
         [] 包装控件
         views: 是一个字典 [名字: 控件名] - VFL 字符串中表示控件的字符串
         metrics: 是一个字典 [名字: NSNumber] - VFL 字符串表示某一个数值
         */
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", options: [], metrics: nil, views: ["mask": maskIconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", options: [], metrics: ["btnHeight": -36], views: ["mask": maskIconView, "regButton": registerButton]))
        */
    }
    
}
