//
//  ModeloDatos.swift
//  TableViewGrouped
//
//  Created by Elard Huaraca on 2/5/21.
//

class ModeloDatos{
    func obtenerSeccionesDesdeDatos() -> [Secciones] {
        var seccionesArray = [Secciones]()
        let peliculas = Secciones(titulo: "Titulo de Peliculas", objetos: ["La milla verde","Ben-Hurs","Million Dollar Baby","La la land"])
        let actores = Secciones(titulo: "Actores", objetos: ["Silvester Stallone","Mia Farrow"])
        let ciudades = Secciones(titulo: "Ciudades del mundo", objetos: ["Madrid","Lima","Mexico","New York"])
        seccionesArray.append(peliculas)
        seccionesArray.append(actores)
        seccionesArray.append(ciudades)
        return seccionesArray
    }
}
