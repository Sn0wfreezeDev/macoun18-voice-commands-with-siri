//
//  ShopItemDetail.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 05.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit
import IntentsUI
import IntentFramework

class ShopItemDetail: UIViewController {
    var item: ShopItem!
    let siriIntentButton = INUIAddVoiceShortcutButton(style: .black)
    let siriDonationButton = INUIAddVoiceShortcutButton(style: .whiteOutline)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userActivity = DonatationManager.viewUserActivity(forItem: item)
        self.addSiriButtons()
        self.displayItemData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addSiriButtons() {
        siriDonationButton.translatesAutoresizingMaskIntoConstraints = false
        siriIntentButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(siriIntentButton)
        self.view.addSubview(siriDonationButton)
        
        siriIntentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0).isActive = true
        siriIntentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        siriIntentButton.addTarget(self, action: #selector(addIntentToSiri), for: .touchUpInside)
        
        siriDonationButton.bottomAnchor.constraint(equalTo: siriIntentButton.topAnchor, constant: -8.0).isActive = true
        siriDonationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        siriDonationButton.addTarget(self, action: #selector(addActivityToSiri), for: .touchUpInside)
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        //Update the userActivities userInfo
        activity.userInfo = ["itemId" : item.id]
    }
    
    
    /// Add the buy activity to invoke it directly from Siri
    @objc func addActivityToSiri() {
        let buyActivity = DonatationManager.buyingUserAcitivity(forItem: self.item)
        let shortcut = INShortcut(userActivity: buyActivity)
        let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func addIntentToSiri() {
        let intent = BuyIntent()
        intent.suggestedInvocationPhrase = String(format: "Kaufe %@ im DemoShop", item.name)
        intent.item = INObject(identifier: String(item.id), display: item.name)
        
        guard let shortcut = INShortcut(intent: intent) else {return}
        let addUI = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        addUI.modalPresentationStyle = .formSheet
        addUI.delegate = self
        self.present(addUI, animated: true, completion: nil)
    }
    
    @IBAction func addPriceRequestToSiri(_ sender: Any) {
        let intent = PriceInfoIntent()
        intent.suggestedInvocationPhrase = String(format: "Aktueller Preis für %@", item.name)
        intent.item = INObject(identifier: String(item.id), display: item.name)
        
        guard let shortcut = INShortcut(intent: intent) else {return}
        let addUI = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        addUI.modalPresentationStyle = .formSheet
        addUI.delegate = self
        self.present(addUI, animated: true, completion: nil)
    }
    
    
    
    /// Buy the item now and add a user acitivity if bought
    ///
    /// - Parameter sender: any button
    @IBAction func buyNow(_ sender: Any) {
        let alertC = UIAlertController(title: "Do you want to buy " + item.name, message: "You can buy this item for " + priceLabel.text!, preferredStyle: .alert)
        alertC.addAction(UIAlertAction(title: "Buy", style: .default, handler: { (_) in
            //Item has been bought
            self.userActivity = DonatationManager.buyingUserAcitivity(forItem: self.item)
        }))
        
        alertC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertC, animated: true, completion: nil)
    }
}


// MARK: - Extension for AddVoiceShortcutDelegate
extension ShopItemDetail: INUIAddVoiceShortcutViewControllerDelegate {
   
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}

