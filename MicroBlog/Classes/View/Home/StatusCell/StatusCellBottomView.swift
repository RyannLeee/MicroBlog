//
//  StatusCellBottomView.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    // 转发按钮
    private lazy var retweetButton = UIButton.init(title: " 转发", fontSize: 12, titleColor: .darkGray, imageName: "timeline_icon_retweet")
    // 评论按钮
    private lazy var commentButton = UIButton.init(title: " 评论", fontSize: 12, titleColor: .darkGray, imageName: "timeline_icon_comment")
    // 点赞按钮
    private lazy var likeButton = UIButton.init(title: " 赞", fontSize: 12, titleColor: .darkGray, imageName: "timeline_icon_unlike")
    
}

// MARK: - 设置界面
extension StatusCellBottomView {
    
    private func setupUI() {
        // 设置背景颜色
        backgroundColor = .init(white: 1.0, alpha: 1.0)
        
        // 1.添加控件
        addSubview(retweetButton)
        addSubview(commentButton)
        addSubview(likeButton)
        
        // 2.自动布局
        retweetButton.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 3.0)
        }
        commentButton.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(retweetButton)
            make.left.equalTo(retweetButton.snp.right)
        }
        likeButton.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(commentButton)
            make.left.equalTo(commentButton.snp.right)
        }
        
        // 3. 分隔视图
        let sep1 = sepView()
        let sep2 = sepView()
        addSubview(sep1)
        addSubview(sep2)
        
        // 布局
        let w = 0.5
        let scale = 0.4
        
        sep1.snp.makeConstraints { (make) in
            make.left.equalTo(retweetButton.snp.right)
            make.centerY.equalTo(retweetButton)
            make.width.equalTo(w)
            make.height.equalTo(retweetButton.snp.height).multipliedBy(scale)
        }
        sep2.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right)
            make.centerY.width.height.equalTo(sep1)
        }
    }
    
    /// 创建分隔视图
    /// - Returns: UIView
    private func sepView() -> UIView {
        let v = UIView()
        v.backgroundColor = .darkGray
        return v
    }
    
}
