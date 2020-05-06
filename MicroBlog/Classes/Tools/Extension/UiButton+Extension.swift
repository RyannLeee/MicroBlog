//
//  UiButton+Extension.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 便利构造函数
    /// - Parameters:
    ///   - imageName: 图像名称
    ///   - backImageName: 背景图像名称
    convenience init(imageName: String, backImageName: String) {
        self.init()
        
        setImage(UIImage.init(named: imageName), for: .normal)
        setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage.init(named: backImageName), for: .normal)
        setBackgroundImage(UIImage.init(named: backImageName + "_highlighted"), for: .highlighted)
        
        // 会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    
    /// 便利构造函数
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字体大小
    ///   - titleColor: 标题颜色
    ///   - backImageName: 背景图像名称
    convenience init(title: String, fontSize: CGFloat = 15, titleColor: UIColor, backImageName: String) {
        self.init()
        
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: fontSize)
        setTitleColor(titleColor, for: .normal)
        
        // 图片拉伸
        let edgeInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        let image = UIImage.init(named: backImageName)?.resizableImage(withCapInsets: edgeInset)
        
        setBackgroundImage(image, for: .normal)
        adjustsImageWhenHighlighted = false
    }
    
    /// 便利构造函数
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字体大小
    ///   - titleColor: 标题颜色
    ///   - imageName: 图像名称
    convenience init(title: String, fontSize: CGFloat = 15, titleColor: UIColor, imageName: String) {
        self.init()
        
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: fontSize)
        setTitleColor(titleColor, for: .normal)
        
        // 图片拉伸
        //let edgeInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        //let image = UIImage.init(named: imageName)?.resizableImage(withCapInsets: edgeInset)
        
        let image = UIImage.init(named: imageName)
        setImage(image, for: .normal)
        adjustsImageWhenHighlighted = false
        
        sizeToFit()
    }
    
}
