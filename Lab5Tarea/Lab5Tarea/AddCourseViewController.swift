//
//  AddCourseViewController.swift
//  Lab5Tarea
//
//  Created by Elard Huaraca on 16/4/21.
//

import UIKit

class AddCourseViewController: UIViewController {
    
    @IBOutlet weak var txtCurso: UITextField!
    @IBOutlet weak var txtNota1Teo: UITextField!
    @IBOutlet weak var txtNota2Teo: UITextField!
    @IBOutlet weak var txtNota3Teo: UITextField!
    @IBOutlet weak var txtNota1Lab: UITextField!
    @IBOutlet weak var txtNota2Lab: UITextField!
    @IBOutlet weak var txtNota3Lab: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnAgregarCurso(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let curso = Curso(context: context)
        curso.nombre = txtCurso.text!
        curso.nota1Teo = Double(txtNota1Teo.text!)!
        curso.nota2Teo = Double(txtNota2Teo.text!)!
        curso.nota3Teo = Double(txtNota3Teo.text!)!
        curso.nota1Lab = Double(txtNota1Lab.text!)!
        curso.nota2Lab = Double(txtNota2Lab.text!)!
        curso.nota3Lab = Double(txtNota3Lab.text!)!
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
}
