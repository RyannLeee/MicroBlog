//
//  LEERefreshControl.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/17.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit

/// 下拉刷新控件偏移量
let LEERefreshControlOffset: CGFloat = -60

/// 自定义刷新控件 - 负责处理刷新逻辑
class LEERefreshControl: UIRefreshControl {

    // MARK: - KVO 监听方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if frame.origin.y > 0 { return }
        
        if frame.origin.y < LEERefreshControlOffset && !refreshView.rotateFlag {
            refreshView.rotateFlag = true
        } else if frame.origin.y >= LEERefreshControlOffset && refreshView.rotateFlag {
            refreshView.rotateFlag = false
        }
        
        print(frame)
    }
    
    // MARK: - 构造函数
    override init() {
        super.init()
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        // 添加控件
        addSubview(refreshView)
        
        // 自动布局 - 从 ‘XIB 加载的控件’ 需要指定大小
        refreshView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(refreshView.bounds.size)
        }
        
        // 使用 KVO 监听位置变化 - 主队列，当主线程有任务，就不调度任务队列中的任务执行
        // 让当前运行循环中所有代码执行完毕后，运行循环结束前，开始监听
        // 方法触发会在下一次运行循环开始
        DispatchQueue.main.async {
            self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
        }
    }
    
    deinit {
        // 删除 KVO 监听方法
        self.removeObserver(self, forKeyPath: "frame")
    }
    
    // MARK: - 懒加载控件
    private lazy var refreshView = LEERefreshView.refreshView()
    
}

/// 刷新视图 - 负责处理动画显示
class LEERefreshView: UIView {
    
    /// 箭头旋转标记
    fileprivate var rotateFlag = false {
        didSet {
            rotateTipIcon()
        }
    }
    
    @IBOutlet weak var tipIconView: UIImageView!
    
    /// 从 XIB 加载视图
    class func refreshView() -> LEERefreshView {
        let nib = UINib.init(nibName: "LEERefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! LEERefreshView
    }
    
    /// 旋转图标动画
    fileprivate func rotateTipIcon() {
        
        var angle = CGFloat(Double.pi)
        angle += rotateFlag ? -1E-7 : 1E-7
        
        /// 旋转动画特点 - 顺时针优先 + ‘就近原则’
        UIView.animate(withDuration: 0.5) {
            //self.tipIconView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
            self.tipIconView.transform = self.tipIconView.transform.rotated(by: angle)
        }
    }
    
}
