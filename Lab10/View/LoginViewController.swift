//
//  LoginViewController.swift
//  Lab10
//
//  Created by Elard Huaraca on 23/5/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var UsernameOrEmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickAuthenticate(_ sender: Any) {
        let username = UsernameOrEmailTxt.text!
        let password = PasswordTxt.text!
        Auth.auth().signIn(withEmail: username, password: password) { (userResponse,error) in
            if(error == nil){
                let user = Auth.auth().currentUser
                self.performSegue(withIdentifier: "loginSegue", sender: user!.email)
            }else{
                let alert = UIAlertController(title: "Error", message: "User or password incorrect", preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
