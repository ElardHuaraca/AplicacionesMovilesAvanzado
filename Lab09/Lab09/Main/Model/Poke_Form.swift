//
//  Pokemon.swift
//  Lab09
//
//  Created by Elard Huaraca on 6/5/21.
//

import Foundation

struct Poke_form: Codable {
    
    let form_name: String
    var form_names = 0
    let form_order: Int
    let id: Int
    let is_battle_only: Bool
    let is_default: Bool
    let is_mega: Bool
    let name: String
    var names = 0;
    let order: Int
    let pokemon: [ListPockemon]
    let sprites: [Sprite]
    var types = 0
    var version_group = 0
}
