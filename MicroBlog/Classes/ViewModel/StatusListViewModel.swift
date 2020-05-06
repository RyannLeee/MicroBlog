//
//  StatusListViewModel.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import Foundation

/// 微博数据列表视图模型 - 封装网络方法
class StatusListViewModel {
    
    /// 微博数据数组 - 上拉/下拉刷新
    lazy var statusList = [StatusViweModel]()
    
    func loadStatus(finished: @escaping (_ isSuccessed: Bool) -> Void) {
        
        NetworkTools.sharedTools.loadStatus { (result, error) -> (Void) in
            if error != nil {
                NSLog("加载微博数据出错")
                
                finished(false)
                return
            }
            
            // 判断 result 的数据结构是否正确
            guard let dicResult = result as? [String : Any], let array = dicResult["statuses"] as? [[String : Any]] else {
                NSLog("微博数据格式错误")
                
                finished(false)
                return
            }
            
            // 遍历字典数组，字典转模型
            // 1.可变数组
            var dataList = [StatusViweModel]()
            
            // 2.遍历数组
            for dict in array {
                dataList.append(StatusViweModel.init(status: Status.init(dict: dict)))
            }
            
            // 3.拼接数据
            NSLog(dataList)
            self.statusList = dataList + self.statusList
            
            // 4.完成回调
            finished(true)
        }
    }
    
}
