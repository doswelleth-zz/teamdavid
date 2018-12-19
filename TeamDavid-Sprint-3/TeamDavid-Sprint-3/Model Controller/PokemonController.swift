//
//  PokemonController.swift
//  TeamDavid-Sprint-3
//
//  Created by David Doswell on 12/18/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    
    var pokemons: [Pokemon] = []
    
    func create(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    func fetch(name: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        
        let input = name.lowercased()
        
        let url = baseURL.appendingPathComponent(input)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            var pokemon: Pokemon
            
            if let error = error {
                NSLog("Error getting data: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(error, nil)
                return
            }
            
            do {
                pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            } catch {
                NSLog("Error fetching data: \(error)")
                completion(error, nil)
                return
            }
            
            pokemon.allTypes = ""
            let allTypesArray = pokemon.types.dropLast().compactMap { $0.name }
            for type in allTypesArray {
                guard var types = pokemon.allTypes else { return }
                types += "\(type), "
                pokemon.allTypes = types
            }
            
            guard let types = pokemon.allTypes,
                let lastType = allTypesArray.last else { return }
            
            let allTypes = types + " " + lastType
            
            pokemon.allTypes = allTypes
            
            pokemon.allAbilities = ""
            let allAbilitiesArray = pokemon.abilities.dropLast().compactMap { $0.name }
            for ability in allAbilitiesArray {
                guard var abilities = pokemon.allAbilities else { return }
                abilities += "\(ability), "
                pokemon.allAbilities = abilities
            }
            
            guard let abilities = pokemon.allAbilities,
                let lastAbility = allAbilitiesArray.last else { return }
            
            let allAbilities = abilities + " " + lastAbility
            
            pokemon.allAbilities = allAbilities
            
            completion(nil, pokemon)
        }.resume()
    }
    
}
