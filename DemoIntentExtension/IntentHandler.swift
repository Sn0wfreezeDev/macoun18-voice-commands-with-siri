//
//  IntentHandler.swift
//  DemoIntentExtension
//
//  Created by Alexander Heinrich on 12.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import Intents
import IntentFramework


class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        if intent is BuyIntent {
            return BuyItemIntentHandler()
        }else if intent is PriceInfoIntent {
            return PriceInfoIntentHandler()
        }
        else {
            fatalError("Unhandled intent type: \(intent)")
        }
    }
}
