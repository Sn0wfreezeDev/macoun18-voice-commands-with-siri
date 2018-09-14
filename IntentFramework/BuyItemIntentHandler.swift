//
//  BuyItemIntentHandler.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 06.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

public class BuyItemIntentHandler: NSObject, BuyIntentHandling {
    public func confirm(intent: BuyIntent, completion: @escaping (BuyIntentResponse) -> Void) {
        /*
         The confirm phase provides an opportunity for you to perform any final validation of the intent parameters and to
         verify that any needed services are available. You might confirm that you can communicate with your company’s server
         */
        
        let shopManager = ShopItemManager()
        
        //Check if this item is available
        guard let item = intent.item,
            let identifier = item.identifier,
            let id = Int(identifier),
            let _ = shopManager.getItem(withId: id) else {
                //Respond with error if item is not available
                completion(BuyIntentResponse(code: .failure, userActivity: nil))
                return
        }
        
        completion(BuyIntentResponse(code: .ready, userActivity: nil))
        
    }
    
    public func handle(intent: BuyIntent, completion: @escaping (BuyIntentResponse) -> Void) {
        
        guard let iItem = intent.item,
            let identifier = iItem.identifier,
            let id = Int(identifier),
            let item = ShopItemManager().getItem(withId: id) else {
                //Respond with error if item is not available
                completion(BuyIntentResponse(code: .failure, userActivity: nil))
                return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "EUR"
        numberFormatter.numberStyle = .currency
        let priceText = numberFormatter.string(from: NSNumber.init(value: item.price)) ?? ""
        
        let response = BuyIntentResponse(code: .success, userActivity: nil)
        response.item = INObject(identifier: String(item.id), display: item.name)
        response.price = priceText
        
        completion(response)
    }
}
