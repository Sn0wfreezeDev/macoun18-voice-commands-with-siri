//
//  ShopItem.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 03.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit

public class ShopItem {
    public let name: String
    public let price: Double
    public let description: String
    public let image: UIImage?
    public let id: Int
    
    public init(id: Int, name: String, price: Double, description: String, image: UIImage?) {
        self.name = name
        self.price = price
        self.description = description
        self.image = image
        self.id = id
    }
    
    public static let defaultItems = [
        ShopItem(id: 0, name: "Kabellose Kopfhörer", price: 129.99, description: "Diese kabellosen Kopfhörer sind super!", image: nil),
        ShopItem(id: 1,name: "USB Kabel", price: 10.99, description: "Dies ist ein USB-A zu USB-A Kabel. Es hat sehr wenig Anwendungsfälle, aber es sieht gut aus", image: nil),
        ShopItem(id: 2,name: "Smartphone", price: 1099, description: "Edge-to-Edge Screen! High End CPU und eine famose Kamera", image: nil)
    ]
}
