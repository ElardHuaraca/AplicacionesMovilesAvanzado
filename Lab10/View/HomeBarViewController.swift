//
//  HomeBarViewController.swift
//  Lab10
//
//  Created by Elard Huaraca on 30/5/21.
//

import UIKit

class HomeBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func SignOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
