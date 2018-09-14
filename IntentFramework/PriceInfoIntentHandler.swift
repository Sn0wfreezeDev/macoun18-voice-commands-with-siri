//
//  PriceInfoIntentHandler.swift
//  IntentFramework
//
//  Created by Alexander Heinrich on 12.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit

public class PriceInfoIntentHandler: NSObject, PriceInfoIntentHandling {
    
    public func handle(intent: PriceInfoIntent, completion: @escaping (PriceInfoIntentResponse) -> Void) {
        guard let iItem = intent.item,
            let identifier = iItem.identifier,
            let id = Int(identifier),
            let item = ShopItemManager().getItem(withId: id) else {
                //Respond with error if item is not available
                let outOfStockResponse = PriceInfoIntentResponse(code: .failureOutOfStock, userActivity: nil)
                outOfStockResponse.item = intent.item
                completion(outOfStockResponse)
                return
        }
        
        //Get the current price
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "EUR"
        numberFormatter.numberStyle = .currency
        let priceText = numberFormatter.string(from: NSNumber.init(value: item.price)) ?? ""
        
        // Respond the current price
        let response = PriceInfoIntentResponse(code: .success, userActivity: nil)
        response.item = intent.item
        response.price = priceText
        
        completion(response)
    }
    
    public func confirm(intent: PriceInfoIntent, completion: @escaping (PriceInfoIntentResponse) -> Void) {
        guard let iItem = intent.item,
            let identifier = iItem.identifier,
            let id = Int(identifier),
            let _ = ShopItemManager().getItem(withId: id) else {
                //Respond with error if item is not available
                let outOfStockResponse = PriceInfoIntentResponse(code: .failureOutOfStock, userActivity: nil)
                outOfStockResponse.item = intent.item
                completion(outOfStockResponse)
                return
            }
        
        //Item is in stock
        completion(PriceInfoIntentResponse(code: .success, userActivity: nil))
    }
}
