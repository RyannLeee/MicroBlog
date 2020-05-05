//
//  OAuthViewController.swift
//  MicroBlog
//
//  Created by Yuan Lee on 2020/4/29.
//  Copyright © 2020 yuanlee. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

/// 用户登录控制器
class OAuthViewController: UIViewController {

    private lazy var webView = WKWebView()
    
    // MARK: 监听方法
    @objc private func close() {
        SVProgressHUD.dismiss()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 设置界面
    override func loadView() {
        view = webView
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = .init(title: "关闭", style: .plain, target: self, action: #selector(self.close))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 加载页面
        webView.load(.init(url: NetworkTools.sharedTools.oauthURL))
    }

}

// MARK: UIWebViewDelegate
extension OAuthViewController: WKUIDelegate, WKNavigationDelegate {
    
    /// 将要加载请求的代理方法
    /// 使用 decisionHandler 回调来决定允许或拒绝跳转 URL
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // 目标：如果是 redirectURL 就不加载
        // 1. 判断访问的主机是否是 www.yuanlee.cc
        guard let url = navigationAction.request.url, url.host == "www.yuanlee.cc" else {
            // 不是则允许加载
            decisionHandler(.allow)
            return
        }
        
        // 2. 从 url 中提取 “code=” 是否存在
        guard let query = url.query, query.hasPrefix("code=") else {
            NSLog("取消授权")
            self.close()
            decisionHandler(.cancel)
            return
        }
        
        // 3. 从 query 中提取 “code=” 后的授权码
        let code = query[query.range(of: "code=")!.upperBound...]
        //print("WKWebView.request:\(navigationAction.request)")
        NSLog("授权码是:" + code)
        
        // 4. 加载 AccessToken
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: String(code)) { isSuccessed in
            if !isSuccessed {
                NSLog("获取AccessToken失败了")
                
                SVProgressHUD.showInfo(withStatus: "您的网络不给力")
                delay(1) { self.close() }
                return
            }
            
            NSLog("获取AccessToken成功了")
            NSLog(UserAccountViewModel.sharedUserAccount.account)
            
            // dismiss 方法不会立即销毁控制器
            self.dismiss(animated: false) {
                // 通知中心是同步的 - 一旦发送通知，会先执行监听方法，执行结束后，再执行后续代码
                NotificationCenter.default.post(name: NSNotification.Name(LEESwitchRootViewControllerNotification), object: "welcome")
            }
        }
        
        // 是 yuanlee.cc 就取消加载
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
}
