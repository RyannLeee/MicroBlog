//
//  UIImageView+Extension.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/9.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 便利构造函数
    /// - Parameter imageName: 图像名称
    convenience init(imageName: String) {
        self.init(image: UIImage.init(named: imageName))
    }
    
}
