//
//  Mazda3.swift
//  lab3
//
//  Created by Elard Huaraca on 25/3/21.
//

import Foundation

class Mazda3 {
    
    var motor:String?
    var nroPuertas:Int?
    var color:String?
    var modelo:String?
    var marca:String?
    
    init(motor:String,nroPuertas:Int,color:String,modelo:String,marca:String) {
        self .motor = motor;
        self .nroPuertas = nroPuertas;
        self .color = color;
        self .modelo = modelo;
        self .marca = marca;
    }
    
    init() {
        self .motor = "Motor turbo"
        self .nroPuertas = 4
        self .color = "Rojo"
        self .modelo = "M-X23"
        self .marca = "Ferrari"
    }
    
    func encenderCarro() -> String {
        return "Carro encendido"
    }
    
    func apagarCarro() -> String {
        return "Carro Apagado"
    }
}
