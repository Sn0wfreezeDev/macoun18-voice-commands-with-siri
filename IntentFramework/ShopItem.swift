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
        ShopItem(id: 0, name: "Wireless Headphones", price: 129.99, description: "This wireless headphones are great. They use noise cancelling", image: nil),
        ShopItem(id: 1,name: "USB Cable", price: 10.99, description: "This USB cable is a USB-A to USB-A cable. It is very useless, but looks nice", image: nil),
        ShopItem(id: 2,name: "Smartphone", price: 1099, description: "An Edge-to-Edge screen. High end computing hardware. A custom calibrated OLED screen", image: nil)
    ]
}
