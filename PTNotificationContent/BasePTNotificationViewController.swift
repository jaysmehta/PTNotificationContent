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
    
    
    func handleAction(_ action: String?) throws -> UNNotificationContentExtensionResponseOption {
        throw NSException(
            name: .internalInconsistencyException,
            reason: "You must override \(NSStringFromSelector(#function)) in a subclass",
            userInfo: nil) as! Error
    }

    
    func getParentViewController() -> PTNotificationViewController? {
        return parent as? PTNotificationViewController
    }

}
