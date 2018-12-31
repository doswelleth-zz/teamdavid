//
//  DODPokemonController.swift
//  TeamDavid-Sprint-9
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

@objc(DODPokemonController)

class PokemonController : NSObject {
    
    @objc(sharedController) static let shared = PokemonController()
    
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([DODPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: PokemonController.baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let results = dictionary["results"] as? [[String: String]] else {
                        
                        NSLog("JSON was not a dictionary")
                        completion(nil, NSError())
                        return
                }
                
                var pokemons: [DODPokemon] = []
                for pokemonDict in results {
                    let pokemon = DODPokemon(dictionary: pokemonDict)
                    pokemons.append(pokemon)
                }
                completion(pokemons, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
                return
            }
            }.resume()
    }
    
    @objc func fillInDetails(for pokemon: DODPokemon) {
        let url = PokemonController.baseURL.appendingPathComponent(pokemon.name).appendingPathComponent("/")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon details: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                pokemon.update(with: dictionary)
            } catch {
                NSLog("Error decoding data: \(error)")
                return
            }
            
            guard let imageURL = pokemon.imageURL else { return }
            URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, _, error) in
                if let error = error {
                    NSLog("Error fetching pokemon image: \(error)")
                    return
                }
                
                guard let data = data,
                    let image = UIImage(data: data) else { return }
                
                pokemon.image = image
            }).resume()
        }.resume()
    }
}
