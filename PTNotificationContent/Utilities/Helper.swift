//
//  Helper.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 20/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import Foundation

class Helper {
    static func getJSONForCarousel (data : [String:AnyObject]) -> [[String:AnyObject]]{
        
        var tempArr = data.filter ({$0.key.contains("pt_")})
        tempArr.removeValue(forKey: "pt_id")
        let totalEle = tempArr.count/4 as Int
        var dataObject : [[String:AnyObject]] = [[:]]
        dataObject.removeAll()
        for i in 1...totalEle {
            let tempArray = tempArr.filter({$0.key.contains("\(i)")})
            dataObject.append(tempArray)
        }
        return dataObject
    }
}
