//
//  ViewController.swift
//  TareaLogin
//
//  Created by Elard Huaraca on 19/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardlabel: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        
        cardlabel.layer.masksToBounds = true
        cardlabel.layer.cornerRadius = 10
        btnLogin.layer.masksToBounds = true
        btnLogin.layer.cornerRadius = 15
        super.viewDidLoad()
    }
}
