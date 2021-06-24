//
//  ProfileViewController.swift
//  Lab10
//
//  Created by Elard Huaraca on 12/6/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imageProfileUser: UIImageView!
    @IBOutlet weak var txtNombreUser: UITextField!
    @IBOutlet weak var txtEmailUser: UITextField!
    var imagePicker = UIImagePickerController()
    var credentetial: AuthCredential?
    var imageChange: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGetstureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(sender:)))
        imageProfileUser.isUserInteractionEnabled = true
        imageProfileUser.addGestureRecognizer(tapGetstureRecognizer)
        
        imageStyle()
        imagePicker.delegate = self
        
        imageProfileUser.observe(\.image, options: [.new], changeHandler: {
            [weak self](object, change) in
            self!.imageChange = true
        })
    }
    
    @IBAction func btnUpdateProfile(_ sender: Any) {
        let user = AuthContext.user()
        if(user.email != txtEmailUser.text){
            let newUser = Auth.auth().currentUser
            newUser?.updateEmail(to: txtEmailUser.text!, completion: { (error) in
                    if (error != nil) {
                        let alert = UIAlertController(title: "Error", message: "Please verify your connection", preferredStyle: .alert)
                        let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(alertaction)
                        self.present(alert, animated: true, completion: nil)
                    }
            })
        }
        print("\(imageChange)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LoadData()
    }
    
    func loadData() throws {
        let user = AuthContext.user()
        Database.database().reference().child("usuarios/\(user.id)").getData(completion: {
            (error,snapchot) in
            let value = snapchot.value as? NSDictionary
            user.username = (value?["username"] as! String)
            user.url = (value?["url_photo"] as! String)
            DispatchQueue.main.async {
                self.txtEmailUser.text = user.email
                self.txtNombreUser.text = user.username
                let s: String? = nil
                if (user.url != s) {
                    let url = URL(string: user.url)
                    let data = try? Data(contentsOf: url!)
                    self.imageProfileUser.image = UIImage(data: data!)
                }
            }
        })
    }
    
    func LoadData() {
        do {
            try loadData()
        } catch {
            let alert = UIAlertController(title: "Error", message: "Please verify your connection", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imageStyle() {
        imageProfileUser.contentMode = .scaleAspectFill
        imageProfileUser.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageProfileUser.layer.borderWidth = 0.5
        imageProfileUser.layer.cornerRadius = imageProfileUser.frame.size.width / 2
        imageProfileUser.clipsToBounds = true
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageProfileUser.image = imageSelected
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
