//
//  StatusCell.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 微博 Cell 中控件的间距数值
let StatusCellMargin: CGFloat = 12
/// 微博头像的宽度
let StatusCellIconWidth: CGFloat = 35

class StatusCell: UITableViewCell {
    
    /// 微博视图模型
    var viewModel: StatusViweModel? {
        didSet {
            // 设置工作
            topView.viewModel = viewModel
            
            contentLabel.text = viewModel?.status.text
        }
    }
    
    // MARK: - 构造函数
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    /// 顶部视图
    private lazy var topView = StatusCellTopView()
    /// 微博正文标签
    private lazy var contentLabel = UILabel.init(title: "微博正文", fontSize: 15, color: .darkGray, screenInset: StatusCellMargin)
    /// 底部视图
    private lazy var bottomView = StatusCellBottomView()
    
}

// MARK: - 设置界面
extension StatusCell {
    
    private func setupUI() {
        
        // 1. 添加控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomView)
        
        // 2. 自动布局
        
        // 顶部视图
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2 * StatusCellMargin + StatusCellIconWidth)
        }
        // 内容标签
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(StatusCellMargin)
            make.left.equalToSuperview().offset(StatusCellMargin)
            
        }
        // 底部视图
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            
            // 指定向下的约束
            make.bottom.equalToSuperview()
        }
    }
    
}
