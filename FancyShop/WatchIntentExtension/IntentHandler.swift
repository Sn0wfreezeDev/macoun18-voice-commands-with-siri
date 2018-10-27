//
//  IntentHandler.swift
//  WatchIntentExtension
//
//  Created by Alexander Heinrich on 15.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import Intents
import WatchFramework

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        if intent is BuyIntent {
            return BuyItemIntentHandler()
        }
        else if intent is PriceInfoIntent {
            return PriceInfoIntent() 
        }
        else {
            fatalError("Unhandled intent type: \(intent)")
        }
    }
}
