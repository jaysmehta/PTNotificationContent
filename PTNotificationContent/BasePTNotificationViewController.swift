//
//  BasePTNotificationViewController.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 14/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI


class BasePTNotificationViewController: UIViewController {

    func configureViewForContent(content : UNNotificationContent) {
        NSException(name: .internalInconsistencyException, reason: "You must override \(#function)) in a subclass", userInfo: nil).raise()
    }
    
    func handleAction(action : String, completionHandler completion : (UNNotificationContentExtensionResponseOption) -> Void) {
        NSException(name: .internalInconsistencyException, reason: "You must override \(#function)) in a subclass", userInfo: nil).raise()
    }
    
    func getParentViewController() -> PTNotificationViewController {
        return parent as! PTNotificationViewController
    }

}
