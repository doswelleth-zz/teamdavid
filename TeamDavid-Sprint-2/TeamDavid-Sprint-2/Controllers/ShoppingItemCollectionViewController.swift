//
//  ShoppingItemCollectionViewController.swift
//  TeamDavid-Sprint-2
//
//  Created by David Doswell on 12/16/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class ShoppingItemCollectionViewController: UICollectionViewController {
    
    let shoppingItemController = ShoppingItemController()
    
    var settingsHelper = SettingsHelper()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        shoppingItemController.loadFromPersistentStore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(ShoppingItemCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsHelper.shoppingItemController.shoppingItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShoppingItemCell
        
        cell.shoppingItem = settingsHelper.shoppingItemController.shoppingItems[indexPath.item]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let destination = segue.destination as! ShoppingItemDetailViewController
            let addedArray = settingsHelper.shoppingItemController.shoppingItems.filter { $0.added }
            let number = addedArray.count
            destination.numberInCart = number
        }
    }
    
}
