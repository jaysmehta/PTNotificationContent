//
//  PTWebViewViewController.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 05/09/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit

class PTWebViewViewController: BasePTNotificationViewController {

    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentView.frame = view.frame
        view.addSubview(contentView)
    }
    
    override func configureViewForContent(content: UNNotificationContent) {
        
       view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width*0.56 + 120)
        contentView.frame = view.frame
        preferredContentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
            
        let webView = PTWebView.init(frame: contentView.frame, webURL: content.userInfo["pt_webURL"] as! String)
        contentView.addSubview(webView)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
