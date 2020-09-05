//
//  PTWebView.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 05/09/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit
import WebKit

class PTWebView: UIView {

    var webView : WKWebView?
    var activityView : UIActivityIndicatorView?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init(frame: CGRect, webURL : String) {
        
        super.init(frame : frame)
        addWebView(frame: frame)
        loadRequest(webURL: webURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addWebView(frame : CGRect){
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: frame, configuration: webConfig)
        webView?.navigationDelegate = self
        addSubview(webView!)
        activityView = UIActivityIndicatorView(style: .gray)
        activityView?.center = self.center
        activityView?.hidesWhenStopped = true
        webView?.addSubview(activityView!)
    }
    
    func loadRequest(webURL : String){
        let myURL = URL(string: webURL)
        if let myURL = myURL {
            let myRequest = URLRequest(url: myURL)
            webView?.load(myRequest)
            activityView?.startAnimating()
        }
    }

}

extension PTWebView : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView?.stopAnimating()
    }
}
