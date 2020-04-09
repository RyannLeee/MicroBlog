//
//  UILabel+Extension.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/9.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 便利构造函数
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize
    ///   - color: color
    /// 参数后面的值是参数的默认值，如果不传递，就使用默认值
    convenience init(title: String, fontSize: CGFloat = 13, color: UIColor = .darkGray) {
        self.init()
        
        text = title
        textColor = color
        font = .systemFont(ofSize: fontSize)
        numberOfLines = 0
        textAlignment = .center
    }
    
}
