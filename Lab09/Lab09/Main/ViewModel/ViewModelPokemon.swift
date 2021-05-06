//
//  ViewModelPokemon.swift
//  Lab09
//
//  Created by Elard Huaraca on 6/5/21.
//

import Foundation

class ViewModelPokemon {
    
    var refreshData = {
        () -> () in
    }
    
    var dataArrayPockemonList: [ListPockemon] = []{
        didSet{
            refreshData()
        }
    }
    
    func getListPockemon() {
        guard  let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        URLSession.shared.dataTask(with: url) {
            (data, repsonse, err) in
            guard let data = data else{ return }
            do{
                let resultApi = try JSONDecoder().decode(Pokedex.self, from: data)
                for pokemon in resultApi.results {
                    self.dataArrayPockemonList.append(pokemon)
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
