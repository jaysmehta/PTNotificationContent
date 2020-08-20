//
//  PTNotificationViewController.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 14/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

enum ContentType : String {
    case slider = "slider"
    case rating = "rating"
    case flatcarousel = "flat_carousel"
    case raisedcarousel = "raised_carousel"
}


open class PTNotificationViewController: UIViewController {

    var contentViewController = BasePTNotificationViewController()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func displayController(contentChildViewController : BasePTNotificationViewController){
        addChild(contentChildViewController)
        contentChildViewController.view.frame = self.view.frame
        view.addSubview(contentChildViewController.view)
        contentChildViewController .didMove(toParent: self)
        contentViewController = contentChildViewController
    }

    open func userDidPerformAction(action : String, withProperties properties : [String : AnyObject]){
        // implement in your subclass to get user event type data
    }
    
    open func openURL(url : URL){ // convenience method
        extensionContext?.open(url, completionHandler: nil)
    }
    
    open func userDidReceiveNotificationResponse(response : UNNotificationResponse){
        // implement in your subclass to get notification response
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

extension PTNotificationViewController : UNNotificationContentExtension {
    
    public func didReceive(_ notification: UNNotification) {
        parseAndCheckTemplate(userInfo: notification.request.content.userInfo as! [String : AnyObject] , notification: notification)
    }
    
    public func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        do{
            let actionResponse = try contentViewController.handleAction(response.actionIdentifier)
            userDidReceiveNotificationResponse(response: response)
            completion(actionResponse)
                   
        }catch let error{
            print(error)
        }
       
    }
    
    func parseAndCheckTemplate(userInfo : [String : AnyObject], notification : UNNotification){
        print(userInfo)
        let strTemplate = userInfo[TemplateType.type] as! String
        let enumTemplate = ContentType(rawValue: strTemplate)
        switch enumTemplate {
        case .slider:
            renderContentSliderTemplate(notification: notification)
        case .rating:
            renderRatingTemplate(notification: notification)
        case .flatcarousel,.raisedcarousel:
            renderCarouselTemplate(notification: notification, templateType: enumTemplate!)
        case .none:
            print("none")
        }
    }
    
    func renderContentSliderTemplate (notification : UNNotification){
        let contentController = PTContentSliderViewController()
        displayController(contentChildViewController: contentController)
        contentViewController.configureViewForContent(content: notification.request.content)
        view.frame = contentViewController.view.frame
        preferredContentSize = contentViewController.preferredContentSize
    }
    
    func renderRatingTemplate (notification : UNNotification){
        let contentController = PTRatingViewController()
        displayController(contentChildViewController: contentController)
    }
    
    func renderCarouselTemplate(notification : UNNotification, templateType : ContentType){
        let contentController = PTContentCarouselViewController()
        if templateType == .raisedcarousel{
            contentController.raisedCarousel = true
        }
        displayController(contentChildViewController: contentController)
        contentViewController.configureViewForContent(content: notification.request.content)
        view.frame = contentViewController.view.frame
        preferredContentSize = contentViewController.preferredContentSize
    }
    
}
