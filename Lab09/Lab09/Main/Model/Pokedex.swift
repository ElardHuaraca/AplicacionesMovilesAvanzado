//
//  Pokedex.swift
//  Lab09
//
//  Created by Elard Huaraca on 6/5/21.
//

import Foundation

struct Pokedex: Codable {
    
    let count: Int
    let results: [ListPockemon]
}
