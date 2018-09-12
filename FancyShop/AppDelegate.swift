//
//  AppDelegate.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 03.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit
import IntentFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabController: UITabBarController? {
        return window?.rootViewController as? UITabBarController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType.hasSuffix(".viewItemActivity") {
            //Show the item
            self.showItem(withUserActivity: userActivity)
            return true
        }
        
        if userActivity.activityType.hasSuffix(".buyItemActivity") {
            //Ask if the item should be bought
            self.buyItem(withUserActivity: userActivity)
            return true
        }
        
        return false
    }
    
    
    /// Show a ShopItem that has been viewed before by reading the NSUserActivity
    ///
    /// - Parameter userActivity: that has been interacted with in Siri
    func showItem(withUserActivity userActivity: NSUserActivity) {
        guard let itemId = userActivity.userInfo?["itemId"] as? Int,
            let item = ShopItem.defaultItems.first(where: {$0.id == itemId}) else {return}
        
        let navController = tabController?.viewControllers?.first as? UINavigationController
        let itemDetailVC = tabController?.storyboard?.instantiateViewController(withIdentifier: "ShopItemDetail") as? ShopItemDetail
        itemDetailVC?.item = item
        navController?.popToRootViewController(animated: false)
        navController?.pushViewController(itemDetailVC!, animated: true)
    }
    
    
    /// Buy an item that has been bought before
    ///
    /// - Parameter userActivity: userActivity describing the action of buying a specific ShopItem
    func buyItem(withUserActivity userActivity: NSUserActivity) {
        guard let itemId = userActivity.userInfo?["itemId"] as? Int,
        let item = ShopItem.defaultItems.first(where: {$0.id == itemId}) else {return}
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "EUR"
        numberFormatter.numberStyle = .currency
        let price = numberFormatter.string(from: NSNumber.init(value: item.price)) ?? String(item.price)
        
        let alertC = UIAlertController(title: "Do you want to buy " + item.name, message: "You can buy this item for " + price, preferredStyle: .alert)
        alertC.addAction(UIAlertAction(title: "Buy", style: .default, handler: { (_) in
            //Item has been bought
        }))
        
        alertC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        tabController?.present(alertC, animated: true, completion: nil)
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

