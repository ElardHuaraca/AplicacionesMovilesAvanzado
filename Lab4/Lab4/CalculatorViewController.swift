//
//  CalculatorViewController.swift
//  Lab4
//
//  Created by Elard Huaraca on 1/4/21.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var InputFirstNumber: UITextField!
    @IBOutlet weak var InputSecondNumber: UITextField!
    @IBOutlet weak var OutputResponse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func sumar(_ sender: Any) {
        calculate(mode:"sumar", text1: InputFirstNumber, text2: InputSecondNumber)
    }
    
    @IBAction func multiplicar(_ sender: Any) {
        calculate(mode: "multiplicar", text1: InputFirstNumber, text2: InputSecondNumber)
    }
    
    @IBAction func dividir(_ sender: Any) {
        calculate(mode: "dividir", text1: InputFirstNumber, text2: InputSecondNumber)
    }
    
    
    @IBAction func restar(_ sender: Any) {
        calculate(mode: "restar", text1: InputFirstNumber, text2: InputSecondNumber)
    }
    
    private func calculate(mode: String, text1: UITextField, text2:UITextField){
        if(text1.text!.isEmpty || text2.text!.isEmpty){
            OutputResponse.text = "Es necesario rellenar los campos"
        }else{
            let number1 = Int(text1.text!)!
            let number2 = Int(text2.text!)!
            var rest = 0;
            	
            switch mode {
            case "sumar":
                rest = number2 + number1
                OutputResponse.text = "La suma es : \(rest)"
            case "restar":
                rest = number1 - number2
                OutputResponse.text = "La resta es : \(rest)"
            case "multiplicar":
                rest = number1 * number2
            OutputResponse.text = "La multiplicacion es : \(rest)"
            case "dividir":
                rest = number1 / number2
                OutputResponse.text = "La divicion es \(rest)"
            default:
                rest = 0
            }
        }
    }
}
