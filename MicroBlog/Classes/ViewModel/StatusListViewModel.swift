//
//  StatusListViewModel.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/5/6.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import Foundation
import SDWebImage
import YYModel

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
            guard let dicResult = result as? [String : Any], let statusDicArray = dicResult["statuses"] as? [[String : Any]] else {
                NSLog("微博数据格式错误")
                
                finished(false)
                return
            }
            
            // 遍历字典数组，字典转模型
            let statusModelArray = NSArray.yy_modelArray(with: Status.self, json: statusDicArray) as! [Status]
            
            // 1.可变数组
            var tempArray = [StatusViweModel]()
            
            // 2.遍历数组
            for status in statusModelArray {
                tempArray.append(StatusViweModel.init(status: status))
            }
            
            // 3.拼接数据
            self.statusList += tempArray
            //NSLog(self.statusList)
            
            // 遍历字典数组，字典转模型
            // 1.可变数组
            //var dataList = [StatusViweModel]()
            
            // 2.遍历数组
            //for dict in statusDicArray {
            //    dataList.append(StatusViweModel.init(status: Status.init(dict: dict)))
            //}
            
            // 3.拼接数据
            //NSLog(dataList)
            //self.statusList = dataList + self.statusList
            
            // 4.缓存单张图片
            self.cacheSingleImage(dataList: self.statusList, finished: finished)
        }
    }
    
    /// 缓存单张图片
    private func cacheSingleImage(dataList: [StatusViweModel], finished: @escaping (_ isSuccessed: Bool) -> Void) {
        
        // 1.创建调度组
        let group = DispatchGroup()
        // 缓存数据长度
        var dataLength = 0
        
        // 2.遍历视图模型数组
        for vm in dataList {
            
            // 判断图片数量是否是单张
            if vm.thumbnailUrls?.count != 1 {
                continue
            }
            
            // 获取 URL
            let url = vm.thumbnailUrls![0]
            NSLog("开始缓存图像[\(url)]")
            
            // SDWebImage - 下载图像（缓存是自动完成的）
            // 入组，监听后续的 block
            group.enter()
            
            // SDWebImage 核心下载函数，如果本地缓存已经存在，同样会通过完成回调返回
            SDWebImageManager.shared.loadImage(with: url, options: [.refreshCached, .retryFailed], progress: nil) { (image, _, _, _, _, _) in
                // 单张图片下载完成 - 计算长度
                if let img = image, let data = img.pngData() {
                    // 累加二进制数据的长度
                    dataLength += data.count
                }
                
                // 出组
                group.leave()
            }
        }
        
        // 3.监听调度组完成
        group.notify(queue: .main) {
            NSLog("缓存图像完成:\(dataLength / 1024)K")
            
            // 4.完成回调 - 控制器才开始刷新表格
            finished(true)
        }
    }
    
    
}
