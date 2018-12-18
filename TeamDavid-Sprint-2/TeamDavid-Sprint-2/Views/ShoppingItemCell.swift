//
//  ShoppingItemCell.swift
//  TeamDavid-Sprint-2
//
//  Created by David Doswell on 12/16/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class ShoppingItemCell: UICollectionViewCell {
    
    @IBOutlet weak var shoppingItemLabel: UILabel!
    @IBOutlet weak var shoppingItemImage: UIImageView!
    @IBOutlet weak var shoppingItemAdded: UILabel!
    
    private func updateViews() {
        guard let name = shoppingItem?.name,
        let added = shoppingItem?.added,
        let imageData = shoppingItem?.image,
        let image = UIImage(data: imageData) else { return }

        shoppingItemLabel.text = name
        shoppingItemLabel.adjustsFontSizeToFitWidth = true
        shoppingItemImage.image = image
        
        if added == true {
            shoppingItemAdded.text = "Added"
        } else {
            shoppingItemAdded.text = "Not Added"
        }
    }

    var shoppingItem: ShoppingItem? {
        didSet {
            updateViews()
        }
    }
    
}
