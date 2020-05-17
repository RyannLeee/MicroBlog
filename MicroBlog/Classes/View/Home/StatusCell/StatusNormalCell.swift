//
//  StatusNormalCell.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/9.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

class StatusNormalCell: StatusCell {

    /// 微博视图模型
    override var viewModel: StatusViweModel? {
        didSet {
            pictureView.snp.updateConstraints { (make) in
                // 根据配图数量，决定配图视图的顶部间距
                let offset = viewModel?.thumbnailUrls?.count ?? 0 > 0 ? StatusCellMargin : 0
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        // 配图视图
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel)
            make.width.equalTo(300)//(contentView.snp.width).offset(-2 * StatusCellMargin)
            make.height.equalTo(90)
        }
    }

}
