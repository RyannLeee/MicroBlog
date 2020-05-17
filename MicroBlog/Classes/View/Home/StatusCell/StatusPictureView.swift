//
//  StatusPictureView.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/7.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit
import SDWebImage

/// 照片之间的间距
private let ItemMargin: CGFloat = 5

/// 可重用标识符
private let StatusPictureCellID = "StatusPictureCellID"
/// 配图视图
class StatusPictureView: UICollectionView {
    
    /// 微博视图模型
    var viewModel: StatusViweModel? {
        didSet {
            sizeToFit()
            
            // 刷新数据 - 如果不刷新，后续的 CollectionView 一旦被复用，不再调用数据源方法
            reloadData()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        calcViewSize()
    }
    
    // MARK: - 构造函数
    init() {
        let layout = UICollectionViewFlowLayout()
        
        // 设置间距 - 默认 itemSize 50 * 50
        layout.minimumLineSpacing = ItemMargin
        layout.minimumInteritemSpacing = ItemMargin
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        //backgroundColor = .init(white: 0.9, alpha: 1.0)
        
        // 设置数据源 - 自己当自己的数据源
        // 应用场景：自定义视图的小框架
        dataSource = self
        
        // 注册可重用 Cell
        register(StatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureCellID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StatusPictureView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.thumbnailUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusPictureCellID, for: indexPath) as! StatusPictureViewCell
        cell.imageUrl = viewModel!.thumbnailUrls![indexPath.row]
        
        return cell
    }
    
}

// MARK: - 计算视图大小
extension StatusPictureView {
    
    /// 计算视图大小
    private func calcViewSize() -> CGSize {
        
        // 1.准备
        // 每行照片数量
        let rowCount: CGFloat = 3
        // 最大宽度
        let maxWidth = UIScreen.main.bounds.width - 2 * StatusCellMargin
        let itemWidth = (maxWidth - 2 * ItemMargin) / rowCount
        
        // 2.设置 layout 的 itemSize
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth)
        
        // 3.获取图片数量
        let count = viewModel?.thumbnailUrls?.count ?? 0
        
        // 计算开始
        // a. 没有图片
        if count == 0 {
            return CGSize.zero
        }
        
        // b. 一张图片
        if count == 1 {
            
            var size = CGSize.init(width: 150, height: 120)
            
            // 利用 SDWebImage 检查本地的缓存图像 - key 就是 url 的完整字符串
            // SDWebImage 是如何设置缓存图片的文件名？ 完整的 URL 字符串 -> ‘MD5’
            if let key = viewModel?.thumbnailUrls?.first?.absoluteString {
                SDWebImageManager.shared.imageCache.queryImage(forKey: key, options: [], context: nil) { (localImage, _, _) in
                    if localImage != nil {
                        size = localImage!.size
                    }
                }
            }
            
            // 过窄处理 - 针对长图
            size.width = size.width < 40 ? 40 : size.width
            // 过宽处理
            if size.width < 300 {
                let w: CGFloat = 300
                let h = size.height * w / size.height
                
                size = CGSize.init(width: w, height: h)
            }
            
            // 内部图片的大小
            layout.itemSize = size
            
            // 配图视图的大小
            return size
        }
        
        // c.四张图片 2 * 2 的大小
        if count == 4 {
            let w = 2 * itemWidth + ItemMargin
            
            return CGSize.init(width: w, height: w)
        }
        
        // d. 其他图片，按照九宫格显示
        // 计算行数
        /*
         2 3
         5 6
         7 8 9
         */
        let row = CGFloat((count - 1) / Int(rowCount) + 1)
        let h = row * itemWidth + (row - 1) * ItemMargin
        let w = rowCount * itemWidth + (rowCount - 1) * ItemMargin
        
        return CGSize.init(width: w, height: h)
    }
    
}

// MARK: - 配图 Cell
private class StatusPictureViewCell: UICollectionViewCell {
    
    
    var imageUrl: URL? {
        didSet {
            iconView.sd_setImage(with: imageUrl, placeholderImage: nil, options:
                [SDWebImageOptions.retryFailed,     // SD 超时时长 15s，一旦超时会记入黑名单
                 SDWebImageOptions.refreshCached])  // 如果 URL 不变，图像变
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
    
    private func setupUI() {
        
        // 1.添加控件
        contentView.addSubview(iconView)
        
        // 2.自动布局 - 因为 Cell 会变化，另外，不同的 Cell 大小可能不一样
        //iconView.frame = bounds
        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    // MARK: - 懒加载控件
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        
        // 设置填充模式
        iv.contentMode = .scaleAspectFill
        // 需要裁切图片
        iv.clipsToBounds = true
        
        return iv
    }()
    
}
