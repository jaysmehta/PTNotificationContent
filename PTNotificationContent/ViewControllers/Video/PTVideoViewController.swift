//
//  PTVideoViewController.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 26/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit


class PTVideoViewController: BasePTNotificationViewController {

    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.frame = view.frame
        view.addSubview(contentView)

        // Do any additional setup after loading the view.
    }
    
    override func configureViewForContent(content: UNNotificationContent) {
        
       view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width*0.56 + 70)
        contentView.frame = view.frame
        preferredContentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
            
        let videoView = VideoView.init(frame: contentView.frame, imageURL: content.userInfo["pt_big_img"] as! String, title: content.userInfo["pt_title"] as! String, subTitle: content.userInfo["pt_msg"] as! String, videoURL : content.userInfo["pt_video_url"] as! String)
        videoView.presentPIPdel = self
        contentView.addSubview(videoView)
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

extension PTVideoViewController : PresentPIP {
    func showPIP(playerVC: UIViewController) {
        present(playerVC, animated: false, completion: nil)
    }
    
    
}
