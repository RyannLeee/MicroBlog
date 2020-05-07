//
//  HomeTableViewController.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 微博 Cell 的可重用符号
let StatusCellNormalID = "StatusCellNormalID"

class HomeTableViewController: VisitorTableViewController {

    /// 微博数据列表模型
    private lazy var listViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UserAccountViewModel.sharedUserAccount.userLogon {
            visitorView?.setupInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        prepareTableView()
        loadData()
        
    }
    
    /// 准备表格
    private func prepareTableView() {
        // 注册可重用 Cell
        tableView.register(StatusCell.self, forCellReuseIdentifier: StatusCellNormalID)
        
        // 取消分隔线
        tableView.separatorStyle = .none
        
        // 预估行高 - 需要尽量准确
        tableView.estimatedRowHeight = 400
    }
    
    /// 加载微博数据
    private func loadData() {
        
        listViewModel.loadStatus { (isSuccessed) in
            
            if !isSuccessed {
                SVProgressHUD.showInfo(withStatus: "加载数据错误，请稍后再试")
                return
            }
            
            // 刷新数据
            self.tableView.reloadData()
        }
    
    }
}

// MARK: - TableView 数据源方法
extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 不会调用行高方法
        // tableView.dequeueReusableCell()
        // 会调用行高方法
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalID, for: indexPath) as! StatusCell
        
        cell.viewModel = listViewModel.statusList[indexPath.row]
        
        return cell
    }
    
    /**
     行高
     
     Current Xcode Version -> 11.4.1 (11E503a)
     
     -- 设置了预估行高
     * 当前显示的行高方法会调用三次（每个版本的 Xcode 调用次数可能会不同）
     
     执行顺序 行数 -> 每个[cell -> 行高]
     
     预估行高不同，计算大的次数不同
     1.使用预估行高，计算出预估的 contentSize
     2.根据预估行高，判断计算次数，顺序计算每一行的行高，更新 contentSize
     3.如果预估行高过大，超出预估范围，顺序计算后续行高，一直到填满屏幕退出，同时更新 contentSize
     4.使用预估行高，每个 cell 的显示前需要计算，单个 cell 的效率是低的，但整体效率高
     
     预估行高: 尽量靠近！
     
     
     -- 没设置预估行高
     * 1.计算所有行的高度 - 三次
     * 2.再计算显示行的高度 - 又三次
     
     执行顺序 行数 -> 行高 -> cell
     
     为什么要调用所有行高方法？UITableView 继承自 UIScrollView
     表格视图滚动流畅 -> 需要提前计算出 contentSize
     
     苹果官方文档有指出，如果行高是固定值，就不要实现行高代理方法！
     
     实际开发中，行高一定要缓存！
     
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        listViewModel.statusList[indexPath.row].rowHeight
    }
    
}
