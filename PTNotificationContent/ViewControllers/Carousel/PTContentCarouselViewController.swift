//
//  PTContentCarouselViewController.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 18/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit

class PTContentCarouselViewController: BasePTNotificationViewController {

    let contentView = UIView()
    var raisedCarousel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentView.frame = view.frame
        view.addSubview(contentView)
        
    }
    
    override func configureViewForContent(content: UNNotificationContent) {
        
        let userInfo = Helper.getJSONForCarousel(data: content.userInfo as! [String : AnyObject])
        
        if raisedCarousel{
            view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (self.view.frame.size.width-50))//Carousel Layout
        }else{
            view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (self.view.frame.size.width-50)*0.56+70)//Normal Flow Layout
        }
        
        contentView.frame = view.frame
        preferredContentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)

        let carouselView = CarouselView.init(frame: contentView.frame, carouselData: userInfo)
        carouselView.setupCollectionView(isRaisedCarousel: raisedCarousel)
        contentView.addSubview(carouselView)
        
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
