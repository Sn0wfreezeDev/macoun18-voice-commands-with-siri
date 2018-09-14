//
//  ShopItemDetailExtension.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 06.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit


extension ShopItemDetail {
    func displayItemData() {
        titleLabel.text = item.name
        imageView.image = item.image
        descriptionLabel.text = item.description
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "EUR"
        numberFormatter.numberStyle = .currency
        priceLabel.text = numberFormatter.string(from: NSNumber.init(value: item.price))
    }
    
    func addButtonDescription() {
        let l1 = UILabel()
        l1.text = "Siri Intent"
        self.view.addSubview(l1)
        l1.centerYAnchor.constraint(equalTo: siriIntentButton.centerYAnchor, constant: 0).isActive = true
        l1.leadingAnchor.constraint(equalTo: siriIntentButton.trailingAnchor, constant: 8.0).isActive = true
        
        let l2 = UILabel()
        l2.text = "Siri Donation"
        self.view.addSubview(l2)
        l2.centerYAnchor.constraint(equalTo: siriDonationButton.centerYAnchor, constant: 0).isActive = true
        l2.leadingAnchor.constraint(equalTo: siriDonationButton.trailingAnchor, constant: 0).isActive = true
    }
}

