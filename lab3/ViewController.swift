//
//  ViewController.swift
//  lab3
//
//  Created by Elard Huaraca on 25/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelModel: UILabel!
    @IBOutlet weak var labelPuertas: UILabel!
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelMotor: UILabel!
    @IBOutlet weak var labelMarca: UILabel!
    @IBOutlet weak var labelEstado: UILabel!
    var objetMazda3:Mazda3?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objetMazda3 = Mazda3()
        labelTitle.text = "Fabrica de carros"
    }
    
    @IBAction func btnAddCar(_ sender: UIButton) {
        labelModel.text = objetMazda3?.modelo
        labelPuertas.text = String( objetMazda3?.nroPuertas ?? 0)
        labelColor.text = objetMazda3?.color
        labelMotor.text = objetMazda3?.motor
        labelMarca.text = objetMazda3?.marca
    }
    
    
    @IBAction func btnEncender(_ sender: UIButton) {
        labelEstado.text = objetMazda3?.encenderCarro()
    }
    
    
    @IBAction func btnApagar(_ sender: UIButton) {
        labelEstado.text = objetMazda3?.apagarCarro()
    }
}

