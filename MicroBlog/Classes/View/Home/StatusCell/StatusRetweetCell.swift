//
//  StatusRetweetCell.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/9.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 转发微博的 Cell
class StatusRetweetCell: StatusCell {
    
    /// 微博视图模型
    /// - 如果继承父类的属性
    /// - 1.需要 override
    /// - 2.不需要 super
    /// - 3.先执行父类的 didSet，再执行子类的 didSet
    /// - 只关心 子类相关设置就够了
    override var viewModel: StatusViweModel? {
        didSet {
            // 转发微博的文字
            retweetLabel.text = viewModel?.retweetText
            
            pictureView.snp.updateConstraints { (make) in
                // 根据配图数量，决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count ?? 0 > 0 ? StatusCellMargin : 0
                make.top.equalTo(retweetLabel.snp.bottom).offset(offset)
            }
        }
    }
    
    // MARK: - 懒加载控件
    /// 背景按钮
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .init(white: 0.95, alpha: 1)
        
        return button
    }()
    
    /// 转发标签
    private lazy var retweetLabel = UILabel.init(title: "转发微博", fontSize: 14, color: .darkGray, screenInset: StatusCellMargin)
    
}


// MARK: - 设置界面
extension StatusRetweetCell {
    
    override func setupUI() {
        super.setupUI()
        
        // 1. 添加控件
        contentView.insertSubview(backButton, belowSubview: pictureView)
        contentView.insertSubview(retweetLabel, aboveSubview: backButton)
        
        // 2. 自动布局
        // 背景按钮
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        // 转发标签
        retweetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButton).offset(StatusCellMargin)
            make.left.equalTo(backButton).offset(StatusCellMargin)
        }
        // 配图视图
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(retweetLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(retweetLabel)
            make.width.equalTo(300)//(contentView.snp.width).offset(-2 * StatusCellMargin)
            make.height.equalTo(90)
        }
    }
    
}
