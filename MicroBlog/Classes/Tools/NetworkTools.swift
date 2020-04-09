//
//  NetworkTools.swift
//  MicroBlog
//
//  Created by yuanlee on 2020/4/9.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit
import AFNetworking

/// 请求方法枚举
enum LEERequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

// MARK: 网络工具
class NetworkTools: AFHTTPSessionManager {
    
    // 单例
    static let sharedTools: NetworkTools = {
       
        let tools = NetworkTools.init(baseURL: nil)
        
        // 设置反序列化数据格式 - 系统会自动将 OC 框架中的 NSSet 转换成 Set
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
        
    }()
    
}

// MARK: 封装 AFN 网络方法
extension NetworkTools {
    
    func request(method: LEERequestMethod, URLString: String, parameters: Any? = nil, finished: @escaping (_ result: Any?, _ error: Error?) -> (Void)) {
        
        // 定义成功回调
        let success = { (task: URLSessionDataTask, result: Any?) in
            finished(result, nil)
        }
        // 定义失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) in
            print(error)
            finished(nil, error)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)
        }
        
    }
    
}
