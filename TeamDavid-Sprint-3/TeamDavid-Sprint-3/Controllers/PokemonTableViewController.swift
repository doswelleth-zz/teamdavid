//
//  PokemonTableViewController.swift
//  TeamDavid-Sprint-3
//
//  Created by David Doswell on 12/18/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class PokemonTableViewController: UITableViewController {
    
    var pokemonController: PokemonController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController?.pokemons.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PokemonTableViewCell
        
        let pokemon = pokemonController?.pokemons[indexPath.row]
        cell.pokemon = pokemon

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let pokemon = pokemonController?.pokemons[indexPath.row] else { return }
            pokemonController?.delete(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearch" {
            let destination = segue.destination as! PokemonSearchViewController
            destination.pokemonController = pokemonController
        } else if segue.identifier == "showDetail" {
            let destination = segue.destination as! PokemonSearchViewController
            let indexPath = tableView.indexPathForSelectedRow!
            guard let pokemons = pokemonController?.pokemons[indexPath.row] else { return }
            destination.pokemon = pokemons
        }
    }
    
}
