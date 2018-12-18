//
//  ShoppingItemDetailViewController.swift
//  TeamDavid-Sprint-2
//
//  Created by David Doswell on 12/16/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class ShoppingItemDetailViewController: UIViewController {
    
    var shoppingItemController: ShoppingItemController?
    
    @IBOutlet weak var shoppingLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    let localNotifications = LocalNotifications()
    var numberInCart: Int?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    
    func updateViews() {
        guard let number = numberInCart else { return }
        shoppingLabel.text = "You currently have \(number) item(s) in your shopping list"
    }
    
    @IBAction func sendOrder(_ sender: Any) {
        guard let name = nameTextField.text, let address = addressTextField.text else { return}
        
        localNotifications.requestAuthorization { (success) in
            if success == true {
                self.localNotifications.sendNotification(name: name, address: address)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
