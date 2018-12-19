//
//  Pokemon.swift
//  TeamDavid-Sprint-3
//
//  Created by David Doswell on 12/18/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    var name: String
    var id: Int
    var types: [Pokemon.TypeArray.TheType]
    var allTypes: String?
    var abilities: [Pokemon.AbilitiesArray.Ability]
    var allAbilities: String?
    
    struct TypeArray: Equatable, Codable {
        var type: Pokemon.TypeArray.TheType
        
        struct TheType: Equatable, Codable {
            var name: String
        }
    }
    
    struct AbilitiesArray: Equatable, Codable {
        var ability: Pokemon.AbilitiesArray.Ability
        
        struct Ability: Equatable, Codable {
            var name: String
        }
    }
}
