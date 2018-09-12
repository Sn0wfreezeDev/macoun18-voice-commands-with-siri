//
//  IntentViewController.swift
//  DemoIntentExtensionUI
//
//  Created by Alexander Heinrich on 12.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import IntentsUI
import IntentFramework

class IntentViewController: UIViewController, INUIHostedViewControlling {
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        switch (interaction.intent) {
        case is BuyIntent:
            self.configureView(withBuyIntent: interaction)
        case is PriceInfoIntent:
            self.configureView(withPriceInfoIntent: interaction)
        default:
            break
        }
        
        completion(true, parameters, self.desiredSize)
    }
    
    func configureView(withBuyIntent interaction: INInteraction) {
        guard let buyIntent = interaction.intent as? BuyIntent,
            let itemId = buyIntent.item?.identifier,
            let id = Int(itemId),
            let item = ShopItemManager().getItem(withId: id) else {return}
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "EUR"
        numberFormatter.numberStyle = .currency
        let priceText = numberFormatter.string(from: NSNumber.init(value: item.price)) ?? "error"
        
        if interaction.intentHandlingStatus == .ready {
                messageLabel.text = String(format: "Möchten Sie %@ für %@", item.name, priceText)
        }else if interaction.intentHandlingStatus == .success {
            messageLabel.text = String(format: "Danke für den Kauf von %@ für %@", item.name, priceText)
        }
        
    }
    
    func configureView(withPriceInfoIntent interaction: INInteraction) {
        guard let buyIntent = interaction.intent as? PriceInfoIntent,
            let itemId = buyIntent.item?.identifier,
            let id = Int(itemId),
            let item = ShopItemManager().getItem(withId: id) else {return}
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "EUR"
        numberFormatter.numberStyle = .currency
        let priceText = numberFormatter.string(from: NSNumber.init(value: item.price)) ?? "error"
        
        if interaction.intentHandlingStatus == .success {
            messageLabel.text = String(format: "Der Artikel %@ ist aktuell bei %@", item.name, priceText)
        }
    }
    
    
    var desiredSize: CGSize {
        var size = self.extensionContext!.hostedViewMaximumAllowedSize
        size.height = 150.0
        return size
    }
    
}
