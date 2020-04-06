//
//  ViewController.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel.init()
        label.text = "Yuan Lee"
        label.textColor = .black
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
        
    }


}

