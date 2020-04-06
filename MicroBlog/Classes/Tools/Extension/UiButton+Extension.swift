//
//  UiButton+Extension.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

extension UIButton {
    
    // 便利构造函数
    convenience init(imageName: String, backImageName: String) {
        self.init()
        
        setImage(UIImage.init(named: imageName), for: .normal)
        setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage.init(named: backImageName), for: .normal)
        setBackgroundImage(UIImage.init(named: backImageName + "_highlighted"), for: .highlighted)
        
        // 会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    
}
