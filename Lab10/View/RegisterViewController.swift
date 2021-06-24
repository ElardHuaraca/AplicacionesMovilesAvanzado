//
//  RegisterViewController.swift
//  Lab10
//
//  Created by Elard Huaraca on 3/6/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasword_repeat: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle(field: txtName)
        setStyle(field: txtEmail)
        setStyle(field: txtPassword)
        setStyle(field: txtPasword_repeat)
    }
    
    func setStyle(field: UITextField) {
        let bottom = CALayer()
        bottom.frame = CGRect(x: 0, y: field.frame.height - 1, width: field.frame.width, height: 1)
        bottom.backgroundColor = UIColor.black.cgColor
        field.borderStyle = .none
        field.layer.addSublayer(bottom)
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func setRedBorder(text: UITextField) {
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.red.cgColor
    }
    
    func createAlert(title: String, msm: String) {
        let alert = UIAlertController(title: title, message: msm, preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerUser(_ sender: Any) {
        var state = false
        if(txtName.text == ""){
            setRedBorder(text: txtName)
            state = true
        }
        if(txtEmail.text == ""){
            setRedBorder(text: txtEmail)
            state = true
        }else{
            if(!validateEmail(email: txtEmail.text!)){
                setRedBorder(text: txtEmail)
                state = true
            }
        }
        if(txtPassword.text == "") {
            setRedBorder(text: txtPassword)
            state = true
        }
        if(txtPasword_repeat.text == ""){
            setRedBorder(text: txtPasword_repeat)
            state = true
        }
        if(txtPassword.text != "" && txtPasword_repeat.text != ""){
            if(!(txtPassword.text == txtPasword_repeat.text)){
                setRedBorder(text: txtPasword_repeat)
                createAlert(title: "Error", msm: "Las contraseñas ingresadas no coinciden")
                state = true
            }else if(txtPassword.text!.count < 7){
                setRedBorder(text: txtPassword)
                createAlert(title: "Error", msm: "La contraseña debe ser como minimo de 7 caracteres")
                state = true
            }
        }
        if(state){
            createAlert(title: "Error", msm: "Campo vacio o mal rellenado")
        }else{
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (response, error) in
                if(error != nil){
                    print(error!)
                    self.createAlert(title: "Error", msm: "Ocurrio un error al crear el usuario")
                }else{
                    let user = Auth.auth().currentUser
                    let map = [
                        "email":user!.email!,
                        "username":self.txtName.text!,
                        "url_photo":""
                    ]
                    Database.database().reference().child("usuarios")
                        .child(user!.uid)
                        .setValue(map)
                    self.performSegue(withIdentifier: "registerSegue", sender: nil)
                }
            })
        }
    }
    
    
    @IBAction func backView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
