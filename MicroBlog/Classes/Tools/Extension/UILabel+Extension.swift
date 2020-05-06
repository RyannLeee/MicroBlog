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
    ///   - screenInset: 相对于屏幕左右的锁进，默认为 0，剧中显示，如果设置，则左对齐
    /// 参数后面的值是参数的默认值，如果不传递，就使用默认值
    convenience init(title: String, fontSize: CGFloat = 13, color: UIColor = .darkGray, screenInset: CGFloat = 0) {
        self.init()
        
        text = title
        textColor = color
        font = .systemFont(ofSize: fontSize)
        numberOfLines = 0
        
        if screenInset == 0 {
            textAlignment = .center
        } else {
            // 设置换行宽度
            preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset
            textAlignment = .left
        }
    }
    
}
