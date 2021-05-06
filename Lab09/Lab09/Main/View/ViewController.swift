//
//  ViewController.swift
//  Lab09
//
//  Created by Elard Huaraca on 6/5/21.
//

import UIKit

class ViewController: UIViewController{

    
    @IBOutlet weak var pokeTextField: UITextField!
    @IBOutlet weak var pokeListPicker: UIPickerView!
    
    var viewPokemodel = ViewModelPokemon()
    var viewPockemon = ViewModelPokemonForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpPicker()
        bind()
        setUpTextField()
    }

    func SetUpPicker(){
        pokeListPicker.delegate = self
        pokeListPicker.dataSource = self
        viewPokemodel.getListPockemon()
    }
    
    func bind(){
        viewPokemodel.refreshData = {
            DispatchQueue.main.async{ [self] in
                self.pokeListPicker.isHidden = true
            }
        }
    }
    
    func setUpTextField() {
        pokeTextField.delegate = self
        pokeTextField.inputView = pokeListPicker
    }
}

extension ViewController:  UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewPokemodel.dataArrayPockemonList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewPokemodel.dataArrayPockemonList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pokeTextField.text = viewPokemodel.dataArrayPockemonList[row].name
        pokeListPicker.isHidden = true
        let spliteado = viewPokemodel.dataArrayPockemonList[row].url.split(separator: "/")
        viewPockemon.getListPockemon(id: "\(spliteado[spliteado.count-1])")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pokeListPicker.isHidden = false
        return false
    }
}

