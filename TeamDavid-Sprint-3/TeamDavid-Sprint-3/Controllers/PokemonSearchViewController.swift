//
//  PokemonSearchViewController.swift
//  TeamDavid-Sprint-3
//
//  Created by David Doswell on 12/18/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let key = "savePokemon"

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        searchBar.delegate = self
        
        UserDefaults.standard.object(forKey: key)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.fetch(name: searchTerm, completion: { (error, pokemon) in
            if let error = error {
                NSLog("Error fetching pokemon: \(searchTerm), \(error)")
                return
        }
            guard let pokemon = self.pokemon else { return }
            self.title = self.pokemon?.name
            self.pokemon = pokemon
        })
    }

    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        typesLabel.text = pokemon.allTypes
        abilitiesLabel.text = pokemon.allAbilities
        
        let defaults = UserDefaults.standard
        defaults.set(pokemon, forKey: key)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            
            self.title = pokemon.name
            nameLabel?.text = pokemon.name
            
            idLabel.text = "ID: \(String(pokemon.id))"
            
            let types = pokemon.types.map { $0.name }.joined(separator: ", ")
            typesLabel?.text = "Types: \(types)"
            
            let abilities = pokemon.abilities.map { $0.name }.joined(separator: ", ")
            abilitiesLabel?.text = "Abilities: \(abilities)"
        } else {
            title = "Pokemon Search"
            nameLabel?.text = ""
            idLabel?.text = ""
            typesLabel?.text = ""
            abilitiesLabel?.text = ""
        }
    }
}
