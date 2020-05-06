//
//  StatusCellTopView.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 顶部视图
class StatusCellTopView: UIView {
    
    /// 微博视图模型
    var viewModel: StatusViweModel? {
        didSet {
            // 姓名
            nameLabel.text = viewModel?.status.user?.screen_name
            // 头像
            iconView.sd_setImage(with: viewModel?.userProfileUrl, placeholderImage: viewModel?.userDefaultIconImage)
            // 会员图标
            memberIconView.image = viewModel?.userMemberImage
            // 认证图标
            vipIconView.image = viewModel?.userVipImage
            
            // TODO: - 后面再改
            // 时间
            timeLabel.text = "刚刚" //viewModel?.status.created_at
            sourceLabel.text = "来自 yuanlee.cc"//viewModel?.status.source
        }
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    /// 头像
    private lazy var iconView = UIImageView.init(imageName: "avatar_default_big")
    /// 姓名
    private lazy var nameLabel = UILabel.init(title: "王老五", fontSize: 14)
    /// 会员图标
    private lazy var memberIconView = UIImageView.init(imageName: "common_icon_membership_level1")
    /// 认证图标
    private lazy var vipIconView = UIImageView.init(imageName: "avatar_vip")
    /// 时间标签
    private lazy var timeLabel = UILabel.init(title: "现在", fontSize: 11, color: .orange)
    /// 来源标签
    private lazy var sourceLabel = UILabel.init(title: "来源", fontSize: 11)
}

// MARK: - 设置界面
extension StatusCellTopView {
    
    private func setupUI() {
        
        // 0. 添加分隔视图
        let sepView = UIView()
        sepView.backgroundColor = .init(white: 0.9, alpha: 1.0)
        addSubview(sepView)
        
        // 1. 添加控件
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        // 2. 自动布局
        sepView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(StatusCellMargin)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(sepView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(self).offset(StatusCellMargin)
            make.width.equalTo(StatusCellIconWidth)
            make.height.equalTo(StatusCellIconWidth)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        memberIconView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(StatusCellMargin)
        }
        vipIconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView.snp.right)
            make.centerY.equalTo(iconView.snp.bottom)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        sourceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp.right).offset(StatusCellMargin)
        }
        
    }
    
}
