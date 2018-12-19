//
//  PokemonTableViewCell.swift
//  TeamDavid-Sprint-3
//
//  Created by David Doswell on 12/18/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        self.nameLabel.text = pokemon.name
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

}
