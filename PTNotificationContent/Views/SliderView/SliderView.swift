//
//  SliderView.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 14/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit

class SliderView: UIView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subCaptionLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var imageURL = "", actionURL = ""
    /*
     
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init(frame: CGRect, imageURL : String,caption : String, subCaption : String,actionURL : String) {
        
        super.init(frame : frame)
        self.imageURL = imageURL
        self.actionURL = actionURL
        let sliderView = loadNib()
        loadImage()
        captionLabel.text = caption
        subCaptionLabel.text = subCaption
        sliderView.frame = bounds
        sliderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layoutIfNeeded()
        addSubview(sliderView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadImage(){
        self.imageView.downloaded(from: self.imageURL)
    }
    
    
}
