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
    
    // MARK: 应用程序信息
    private let appKey = "538314538"
    private let appSecret = "7688004be36d1c5e51afbbb0a63b8aae"
    private let redirectUrl = "http://www.yuanlee.cc"
    
    // 类似于 OC 的 typeDefine，网络请求完成回调
    typealias LEERequestCallBack = (_ result: Any?, _ error: Error?) -> (Void)
    
    // 单例
    static let sharedTools: NetworkTools = {
       
        let tools = NetworkTools.init(baseURL: nil)
        
        // 设置反序列化数据格式 - 系统会自动将 OC 框架中的 NSSet 转换成 Set
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
        
    }()
    
}

// MARK: 封装 OAuth 相关方法
extension NetworkTools {
    
    /// OAuth 授权 URL
    /// - see: [https://open.weibo.com/wiki/Oauth2/authorize](https://open.weibo.com/wiki/Oauth2/authorize)
    internal var oauthURL: URL {
        let urlSring = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        return URL.init(string: urlSring)!
    }
    
    /// 加载 AccessToken
    /// - Parameter code: 获取到的授权码
    /// - finished: 完成回调
    internal func loadAccessToken(code: String, finished: @escaping LEERequestCallBack) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id": appKey,
                      "client_secret": appSecret,
                      "grant_type": "authorization_code",
                      "code": code,
                      "redirect_uri": redirectUrl]
        request(method: .POST, URLString: urlString, parameters: params, finished: finished)
    }
}

// MARK: 封装 AFN 网络方法
extension NetworkTools {
    
    /// 网络请求
    /// - Parameters:
    ///   - method: GET / POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - finished: 完成回调
    ///   - result: 返回的数据
    ///   - error: 返回的错误信息
    private func request(method: LEERequestMethod, URLString: String, parameters: Any? = nil, finished: @escaping LEERequestCallBack) {
        
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
