//
//  ShoppingItemController.swift
//  TeamDavid-Sprint-2
//
//  Created by David Doswell on 12/16/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class ShoppingItemController {
    
    init() {
        loadFromPersistentStore()
    }
    
    var shoppingItems: [ShoppingItem] = []
    
    func update(item: ShoppingItem) {
        guard let index = shoppingItems.index(of: item) else { return }
        shoppingItems[index].added = !item.added
    }
    
    var shoppingItemsURL: URL? {
        let fm = FileManager.default
        let fileName = "ShoppingItems.plist"
        guard let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let shoppingListDir = docDir.appendingPathComponent(fileName)
        return shoppingListDir
    }
    
    
    func saveToPersistentStore() {
        guard let url = shoppingItemsURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(shoppingItems)
            try data.write(to: url)
        } catch {
            NSLog("Error saving data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = shoppingItemsURL else { return }
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decoded = try decoder.decode([ShoppingItem].self, from: data)
            shoppingItems = decoded
        } catch {
            NSLog("Error loading Data: \(error)")
        }
    }
    
    func saveGivenItemsToPersistentStore() {
        let itemNames = ["apple", "grapes", "milk", "muffin", "popcorn", "soda", "strawberries"]
        for item in itemNames {
            guard let image = UIImage(named: item),
                let imageData = image.pngData() else {
                    return
            }
            let shoppingItem = ShoppingItem(name: item, image: imageData, added: false)
            shoppingItems.append(shoppingItem)
        }
        saveToPersistentStore()
    }
    
}
