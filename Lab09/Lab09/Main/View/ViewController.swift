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
    @IBOutlet weak var pokeImage: UIImageView!
    
    var viewPokemodel = ViewModelPokemon()
    var viewPokemoDetail = ViewModelpokemonImages()
    
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
        viewPokemoDetail.getListPockemon(name: viewPokemodel.dataArrayPockemonList [row].name)
        setImage()
        
        pokeListPicker.isHidden = true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pokeListPicker.isHidden = false
        return false
    }
    
    func getDataFromImage(url: String) -> Data {
        let url = URL(string: viewPokemoDetail.ListDetails!.front_default)
        let data = try? Data(contentsOf: url!)
        return data!
    }
    
    func setImage() {
        viewPokemoDetail.refreshData = {
            DispatchQueue.main.async { [self] in
                self.pokeImage.image = UIImage(data: getDataFromImage(url:  self.viewPokemoDetail.ListDetails!.front_default))
            }
        }
    }
}

