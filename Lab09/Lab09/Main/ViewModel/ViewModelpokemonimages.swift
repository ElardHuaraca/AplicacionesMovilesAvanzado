//
//  ViewModelpokemonimages.swift
//  Lab09
//
//  Created by Elard Huaraca on 9/5/21.
//

import Foundation

class ViewModelpokemonImages {
    
    var refreshData = {
        () -> () in
    }
    
    var ListDetails: PokemonImages? {
        didSet{
            refreshData()
        }
    }
    
    func getListPockemon(name: String) {
        guard  let url = URL(string: "https://pokeapi.co/api/v2/pokemon-form/\(name)/") else { return }
        URLSession.shared.dataTask(with: url) {
            (data, repsonse, err) in
            guard let data = data else{ return }
            do{
                let resultApi = try JSONDecoder().decode(PokemonDetails.self, from: data)
                self.ListDetails = resultApi.sprites
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
