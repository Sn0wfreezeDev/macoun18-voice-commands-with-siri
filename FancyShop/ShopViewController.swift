//
//  ViewController.swift
//  FancyShop
//
//  Created by Alexander Heinrich on 03.09.18.
//  Copyright © 2018 Alexander Heinrich. All rights reserved.
//

import UIKit
import IntentFramework

class ShopViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = self.tableView.indexPathForSelectedRow else {return}
        
        let item = ShopItem.defaultItems[selectedIndex.row]
        
        if let detailView = segue.destination as? ShopItemDetail {
            detailView.item = item
        }
        tableView.deselectRow(at: selectedIndex, animated: true)
    }

}

extension ShopViewController: UITableViewDelegate {
    
}

extension ShopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShopItem.defaultItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopItemCell", for: indexPath) as! ShopItemCell
        let shopItem = ShopItem.defaultItems[indexPath.row]
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "EUR"
        
        numberFormatter.numberStyle = .currency
        cell.textLabel?.text = shopItem.name
        cell.detailTextLabel?.text = numberFormatter.string(from: NSNumber.init(value: shopItem.price))
        
        return cell
    }
    
    
}

