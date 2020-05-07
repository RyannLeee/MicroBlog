//
//  StatusCell.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 微博 Cell 中控件的间距数值
let StatusCellMargin: CGFloat = 10
/// 微博头像的宽度
let StatusCellIconWidth: CGFloat = 35

class StatusCell: UITableViewCell {
    
    /// 微博视图模型
    var viewModel: StatusViweModel? {
        didSet {
            // 设置工作
            topView.viewModel = viewModel
            
            contentLabel.text = viewModel?.status.text
            
            // 设置配图视图
            pictureView.viewModel = viewModel
            
            // 测试修改配图视图高度 - 实际开发中需要注意，如果动态修改约束的高度，可能会导致行高计算有误
            pictureView.snp.updateConstraints { (make) in
                make.height.equalTo(pictureView.bounds.height)
                // 直接设置宽度数值
                make.width.equalTo(pictureView.bounds.width)
                
                // 根据配图数量，决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count ?? 0 > 0 ? StatusCellMargin : 0
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
        }
    }
    
    /// 根据指定的视图模型计算行高
    /// - Parameter vm: 视图模型
    /// - Returns: 返回视图模型对应的行高
    func rowHeight(vm: StatusViweModel) -> CGFloat {
        
        // 1. 记录视图模型 -> 会调用上面的 didSet 设置内容以及更新‘约束’
        viewModel = vm
        
        // 2. 强制更新所有约束 -> 所有控件的 frame 都会被计算正确
        contentView.layoutIfNeeded()
        
        // 3. 返回底部视图的最大高度
        return bottomView.frame.maxY
    }
    
    // MARK: - 构造函数
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    /// 顶部视图
    private lazy var topView = StatusCellTopView()
    /// 微博正文标签
    private lazy var contentLabel = UILabel.init(title: "微博正文", fontSize: 15, color: .darkGray, screenInset: StatusCellMargin)
    /// 配图视图
    private lazy var pictureView = StatusPictureView()
    /// 底部视图
    private lazy var bottomView = StatusCellBottomView()
    
}

// MARK: - 设置界面
extension StatusCell {
    
    private func setupUI() {
        
        // 1. 添加控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
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
        // 配图视图
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel)
            make.width.equalTo(300)//(contentView.snp.width).offset(-2 * StatusCellMargin)
            make.height.equalTo(90)
        }
        // 底部视图
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            
            // 指定向下的约束
            //make.bottom.equalToSuperview()
        }
    }
    
}
