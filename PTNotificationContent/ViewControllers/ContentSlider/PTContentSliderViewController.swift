//
//  PTContentSliderViewController.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 14/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class PTContentSliderViewController: BasePTNotificationViewController {

    let contentView = UIView()
    var itemsData : [[String:AnyObject]] = [[:]]
    var itemModel : [SliderView] = []
    var timerAutoPlay : Timer?
    var pageControl : UIPageControl?
    var currentView : SliderView?
    var currentIndex = 0
    var transitioning : Bool = false, showsPaging : Bool = false, autoDismiss : Bool =  false, autoPlay : Bool = false
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentView.frame = view.frame
        view.addSubview(contentView)
    }
    
    override func configureViewForContent(content: UNNotificationContent) {
        let config = content.userInfo[ContentSlider.contentSliderObject] as! [String : AnyObject]
        let items = config[ContentSlider.itemsObject] as! [[String:AnyObject]]
        itemsData.removeAll()
        itemsData = items
        
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width*0.56 + 60)
        contentView.frame = view.frame
        preferredContentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        
        for view in itemModel {
            view.superview?.removeFromSuperview()
        }
        
        itemModel.removeAll()
        
        for item in items{
            let imageURL = item[ContentSlider.imageURL] as! String
            let caption = item[ContentSlider.caption] as! String
            let subCaption = item[ContentSlider.subCaption] as! String
            let actionURL = item[ContentSlider.actionURL] as! String
            let sliderView = SliderView.init(frame: contentView.frame, imageURL: imageURL, caption: caption, subCaption: subCaption, actionURL: actionURL)
            itemModel.append(sliderView)
        }
        
        autoPlay = config[ContentSlider.autoPlay] as! Bool
        showsPaging = config[ContentSlider.showPaging] as! Bool
        autoDismiss = config[ContentSlider.autoDismiss] as! Bool
        
        if showsPaging{
            setupPageControl()
        }
        
        showNext()
        
        if autoPlay{
            startAutoPlay()
        }else{
            stopAutoPlay()
        }
        
        
    }
    
    func setupPageControl(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.size.width*0.56-30, width: contentView.frame.size.width, height: 20))
        pageControl?.numberOfPages = itemModel.count
        pageControl?.hidesForSinglePage = true
        view.addSubview(pageControl!)
    }
    
    @objc func showNext(){
        moveSlider(direction: 1)
    }
    
    func showPrevious(){
        moveSlider(direction: -1)
    }
    
    func moveSlider(direction : Int) {
        let numItems = itemModel.count
        
        if transitioning || numItems < 0 {
            return
        }
        transitioning = true
        
        let oldView = currentView
        if oldView == nil {
            currentIndex = 0
        }else{
            currentIndex+=direction
            if currentIndex >= numItems{
                currentIndex = 0
            }else if currentIndex < 0{
                currentIndex = numItems-1
            }
        }
        currentView = itemModel[currentIndex]
        if (currentView == nil) {
            return
        }
        pageControl?.currentPage = currentIndex
        
        if (oldView != nil) && numItems > 1{
            UIView.transition(from: oldView!, to: currentView!, duration: 0.4, options: .transitionCrossDissolve) { (_) in
                self.transitioning = false
            }
        }else{
            contentView.addSubview(currentView!)
            transitioning = false
        }
        
        getParentViewController()?.userDidPerformAction(action: ContentSlider.viewContentItem, withProperties: itemsData[currentIndex])
    }
    
    func startAutoPlay(){
        if timerAutoPlay == nil{
            timerAutoPlay = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.showNext), userInfo: nil, repeats: true)
        }
    }
    
    func stopAutoPlay(){
        timerAutoPlay?.invalidate()
        timerAutoPlay = nil
    }
    
    override func handleAction(_ action: String?) throws -> UNNotificationContentExtensionResponseOption {
        if action == SliderActions.actionOne{
            stopAutoPlay()
            showPrevious()
        }else if action == SliderActions.actionTwo{
            stopAutoPlay()
            showNext()
        }else if action == SliderActions.actionThree{
            stopAutoPlay()
            if itemModel.count > 0 {
                let urlString = itemModel[currentIndex].actionURL
                if urlString != ""{
                    getParentViewController()?.userDidPerformAction(action: ContentSlider.openedContentURL, withProperties: itemsData[currentIndex])
                    getParentViewController()?.openURL(url: URL(string: urlString)!)
                }
                
                return autoDismiss ? UNNotificationContentExtensionResponseOption.dismiss : UNNotificationContentExtensionResponseOption.doNotDismiss
                
            }
        }
        
        return UNNotificationContentExtensionResponseOption.doNotDismiss
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
