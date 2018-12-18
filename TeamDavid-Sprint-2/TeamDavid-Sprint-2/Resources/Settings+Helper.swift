//
//  Settings+Helper.swift
//  TeamDavid-Sprint-2
//
//  Created by David Doswell on 12/18/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

class SettingsHelper {
    
    init() {
        guard shoppingItemsValue else {
            setShoppingItemsToProvided()
            return
        }
    }
    
    let shoppingItemsKey = "Shopping Items"
    let providedValue = true
    let interactiveValue = false
    
    var shoppingItemController = ShoppingItemController()
    
    var shoppingItemsValue: Bool {
        return UserDefaults.standard.bool(forKey: shoppingItemsKey)
    }
    
    func setShoppingItemsToProvided() {
        UserDefaults.standard.set(providedValue, forKey: shoppingItemsKey)
        shoppingItemController.saveToPersistentStore()
    }
    
    func setShoppingItemsToInteractive() {
        UserDefaults.standard.set(interactiveValue, forKey: shoppingItemsKey)
    }
    
}
