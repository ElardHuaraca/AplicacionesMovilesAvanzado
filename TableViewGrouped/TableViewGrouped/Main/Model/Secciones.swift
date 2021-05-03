//
//  Secciones.swift
//  TableViewGrouped
//
//  Created by Elard Huaraca on 2/5/21.
//

struct Secciones {
    var cabecera: String
    var items: [String]
    
    init(titulo: String, objetos: [String]) {
        cabecera = titulo
        items = objetos
    }
}
