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
private let StatusCellNormalID = "StatusCellNormalID"

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
        
        // 自动计算行高 - 需要一个自上而下的自动布局的空间，指定一个向下的约束
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
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
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalID, for: indexPath) as! StatusCell
        
        cell.viewModel = listViewModel.statusList[indexPath.row]
        
        return cell
    }
    
}
