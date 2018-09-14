//
//  DonatationManager.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 06.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit
import IntentFramework

class DonatationManager {
    static private let bundleId = "de.heinrich.alexander.FancyShop"
    
    
    /// Creates a new NSUserActivity for the action of buying an item
    ///
    /// - Parameter item: a shop item that has been bought
    /// - Returns: a userActivity for buying this item
    static func buyingUserAcitivity(forItem item: ShopItem) -> NSUserActivity {
        let userActivity = NSUserActivity(activityType: bundleId + ".buyItemActivity")
        userActivity.title = "Buy " + item.name
        userActivity.isEligibleForSearch = true
        userActivity.isEligibleForPrediction = true
        userActivity.userInfo = ["itemId" : item.id]
        return userActivity
    }
    
    
    /// Creates a new NSUserActivity for the action of viewing an item
    ///
    /// - Parameter item: a shop item that is the user is viewing
    /// - Returns: a userActivity for viewing this item
    static func viewUserActivity(forItem item: ShopItem) -> NSUserActivity {
        let userActivity = NSUserActivity(activityType: bundleId + ".viewItemActivity")
        userActivity.title = "View " + item.name
        userActivity.isEligibleForSearch = true
        userActivity.isEligibleForPrediction = true
        userActivity.userInfo = ["itemId" : item.id]
        
        return userActivity
    }
}
