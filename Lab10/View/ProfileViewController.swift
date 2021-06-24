//
//  ProfileViewController.swift
//  Lab10
//
//  Created by Elard Huaraca on 12/6/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imageProfileUser: UIImageView!
    @IBOutlet weak var txtNombreUser: UITextField!
    @IBOutlet weak var txtEmailUser: UITextField!
    @IBOutlet weak var tabIndicadot: UIView!
    @IBOutlet weak var giftIndicator: UIActivityIndicatorView!
    
    private var imageChangedObserve: NSKeyValueObservation?
    var imagePicker = UIImagePickerController()
    var imageChange: Bool?
    var username: String?
    
    override func viewDidLoad() {
        self.imagePicker.delegate = self
        super.viewDidLoad()
        let tapGetstureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(sender:)))
        imageProfileUser.isUserInteractionEnabled = true
        imageProfileUser.addGestureRecognizer(tapGetstureRecognizer)
        
        imageStyle()
        
        imageChangedObserve = imageProfileUser.observe(\.image, options: [.old,.new]) {
            object, change in
            self.imageChange = true
        }
    }
    
    @IBAction func btnUpdateProfile(_ sender: Any) {
        let user = AuthContext.user()
        if(user.email != self.txtEmailUser.text!){
            let newUser = Auth.auth().currentUser
            newUser?.updateEmail(to: self.txtEmailUser.text!, completion: { (error) in
                    if (error != nil) {
                        self.createAlert(title: "Error", msm: "Plase Verify Your Connection")
                        return
                    }
                self.updateProfile(user: User(email: self.txtEmailUser.text!, id: user.id, username: "", url: ""))
            })
        }
        if(imageChange!){
            let imgData = self.imageProfileUser.image!.jpegData(compressionQuality: 0.5)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let storageRef = Storage.storage().reference().child("\(randomString()).jpg")
            storageRef.putData(imgData!, metadata: metadata){
                (metadata, err) in
                guard metadata != nil else{
                    self.createAlert(title: "Error", msm: "Ocurred Error on Upload Image")
                    return
                }
                storageRef.downloadURL(completion: {
                    (url, err) in
                    if(err != nil){
                        self.createAlert(title: "Error", msm: "Error with get URL Image")
                        return
                    }
                    self.updateProfile(user: User(email: "", id: user.id, username: "", url: "\(url!)"))
                })
            }
        }
        if(username != txtNombreUser.text! && username != ""){
            updateProfile(user: User(email: "", id: user.id, username: txtNombreUser.text!, url: ""))
            username = txtNombreUser.text!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        giftIndicator.startAnimating()
        LoadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        giftIndicator.startAnimating()
        giftIndicator.isHidden = false
        tabIndicadot.isHidden = false
    }
    
    func loadData() throws {
        let user = AuthContext.user()
        Database.database().reference().child("usuarios/\(user.id)").getData(completion: {
            (error,snapchot) in
            let value = snapchot.value as? NSDictionary
	            user.url = value?["url_photo"] as! String
            user.username = value?["username"] as! String
            DispatchQueue.main.async {
                self.txtEmailUser.text = user.email
                self.txtNombreUser.text = user.username
                self.username = user.username
                let s: String? = nil
                if (user.url != s && user.url != "") {
                    let url = URL(string: user.url)
                    let data = try? Data(contentsOf: url!)
                    self.imageProfileUser.image = UIImage(data: data!)
                    self.imageChange = false
                }
                self.giftIndicator.stopAnimating()
                self.giftIndicator.isHidden = true
                self.tabIndicadot.isHidden = true
            }
        })
    }
    
    func LoadData() {
        do {
            try loadData()
        } catch {
            createAlert(title: "Error", msm: "Plase Verify your connection")
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
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageProfileUser.image = imageSelected
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func createAlert(title: String, msm: String) {
        let alert = UIAlertController(title: title, message: msm, preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func randomString() -> String {
        let letters = "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789"
        return String((0..<30).map{ _ in letters.randomElement()! })
    }
    
    func updateProfile(user:User){
        let ref = Database.database().reference().child("usuarios")
        if(user.email != ""){
            ref.child(user.id).updateChildValues([
                "email":user.email
            ])
        }
        if(user.url != ""){
            ref.child(user.id).updateChildValues([
                "url_photo":user.url
            ])
        }
        if(user.username != ""){
            ref.child(user.id).updateChildValues([
                "username":user.username
            ])
        }
    }
}
