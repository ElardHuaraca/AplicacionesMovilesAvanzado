//
//  ViewModelPokemonForm.swift
//  Lab09
//
//  Created by Elard Huaraca on 6/5/21.
//

import Foundation

class ViewModelPokemonForm {
    
    var refreshData = {
        () -> () in
    }
    
    var dataArrayPockemonList: Poke_form? = nil {
        didSet{
            refreshData()
        }
    }
    
    func getListPockemon(id: String) {
        guard  let url = URL(string: "https://pokeapi.co/api/v2/pokemon-form/\(id)/") else { return }
        URLSession.shared.dataTask(with: url) {
            (data, repsonse, err) in
            guard let data = data else{ return }
            print(url)
            do{
                let resultApi = try JSONDecoder().decode( Poke_form.self, from: data)
                print(resultApi.name)
                for pk in resultApi.sprites{
                    print(pk.back_default)
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
