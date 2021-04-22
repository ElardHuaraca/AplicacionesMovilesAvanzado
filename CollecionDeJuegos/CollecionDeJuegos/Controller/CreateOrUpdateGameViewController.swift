//
//  CreateOrUpdateGameViewController.swift
//  CollecionDeJuegos
//
//  Created by Elard Huaraca on 15/4/21.
//

import UIKit

class CreateOrUpdateGameViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var btnCameraOrGalery: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtTitulo: UITextField!
    var juego:Juego? = nil
    @IBOutlet weak var btnAddOrUpdate: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var imagePiker = UIImagePickerController()
    
    override func viewDidLoad() {
        imagePiker.delegate = self
        super.viewDidLoad()
        
        if(juego != nil){
            imageView.image = UIImage(data: (juego?.imagen!)!)
            txtTitulo.text = juego?.titulo
            btnAddOrUpdate.setTitle("Actualizar", for: .normal)
        }else{
            btnDelete.isHidden = true
        }
        
        btnCameraOrGalery.image = UIImage(named: "camara")?.withRenderingMode(.alwaysOriginal)
    }
    
    @IBAction func onClckAlertCameraOrGalery(_ sender: Any) {
        let alert = UIAlertController(title: "Semana 6", message: "Decea acceder a la ¿camara o la galeria?",preferredStyle: .actionSheet)
        //tambien se puede cambiar a .alert pero esta hara que aparesca una alerta en medio de la pantalla
        
        alert.addAction(UIAlertAction(title: "Camara", style: .default, handler: {
            _ in
            self.imagePiker.sourceType = .camera
            self.present(self.imagePiker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: {
            _ in
            self.imagePiker.sourceType = .photoLibrary
            self.present(self.imagePiker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        imagePiker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if(juego != nil){
            juego?.titulo = txtTitulo.text
            juego?.imagen = imageView.image?.pngData()
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = txtTitulo.text
            juego.imagen = imageView.image!.pngData()
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}
