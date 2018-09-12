//
//  ShopItemManager.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 06.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit

public class ShopItemManager: NSObject {
    
    public func getItem(withId id: Int) -> ShopItem? {
        return ShopItem.defaultItems.first(where: {$0.id == id})
    }

}
