//
//  VideoView.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 26/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol PresentPIP {
    func showPIP(playerVC : UIViewController)
}


class VideoView: UIView {

    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var playerController : AVPlayerViewController!
    var presentPIPdel : PresentPIP?
    var videoURL = ""
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(frame: CGRect, imageURL : String, title : String, subTitle: String, videoURL : String) {
        
        super.init(frame : frame)
        let videoView = loadNib()
        videoView.frame = bounds
        videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(videoView)
        imageView.downloaded(from: imageURL)
        playImageView.isHidden = false
        titleLabel.text = title
        msgLabel.text = subTitle
        self.videoURL = videoURL
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    @objc func imageTapped() {
        let player = AVPlayer(url: URL(string: self.videoURL)!)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.delegate = self
        playerController.view.frame = self.frame
        playerController.player?.play()
        presentPIPdel?.showPIP(playerVC: playerController)
        
    }
    
    
    
}

extension VideoView : AVPlayerViewControllerDelegate {
    
    
}
