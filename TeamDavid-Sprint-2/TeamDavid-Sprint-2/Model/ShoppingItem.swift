//
//  ShoppingItem.swift
//  TeamDavid-Sprint-2
//
//  Created by David Doswell on 12/16/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct ShoppingItem: Codable, Equatable {
    var name: String
    var image: Data
    var added: Bool = false
    
    init(name: String, image: Data, added: Bool = false) {
        self.name = name
        self.image = image
        self.added = added
    }
}

struct ShoppingList {
    var itemNames = ["apple", "grapes", "milk", "muffin", "popcorn", "soda", "strawberries"]
}
