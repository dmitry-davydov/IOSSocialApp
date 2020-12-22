//
//  LoginViewController.swift
//  SocialApp
//
//  Created by Дима Давыдов on 30.09.2020.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: LoginService.shared.oAuthLoginUrl().url!)
        webView.load(request)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    private func navigateToEntryPoint() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabViewController") as! TabViewController
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DemoViewController") as! DemoViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        decisionHandler(.cancel)
        
        debugPrint("AUTH params")
        debugPrint(params)
        
        if let token = params["access_token"], let userId = params["user_id"] {
            LoginService.shared.setAuthToken(userId: userId, token: token)
            navigateToEntryPoint()
        }
    }
}
