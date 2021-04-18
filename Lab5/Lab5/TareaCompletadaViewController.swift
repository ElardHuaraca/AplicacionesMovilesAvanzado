//
//  TareaCompletadaViewController.swift
//  Lab5
//
//  Created by Elard Huaraca on 13/4/21.
//

import UIKit

class TareaCompletadaViewController: UIViewController {
    
    @IBOutlet weak var tareaLabel: UILabel!
    var tarea:Tarea? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tarea!.importante {
            tareaLabel.text = "❗️\(String(describing: tarea!.nombre!))"
        }else{
            tareaLabel.text = tarea!.nombre!
        }
    }
    
    @IBAction func completarTarea(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(tarea!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
}
