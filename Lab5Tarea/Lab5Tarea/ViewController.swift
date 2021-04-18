//
//  ViewController.swift
//  Lab5Tarea
//
//  Created by Elard Huaraca on 16/4/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
       

    @IBOutlet weak var tableView: UITableView!
    var cursos:[Curso] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cursos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let curso = cursos[indexPath.row]
        let state = verifyState(nota1Teo: curso.nota1Teo, nota2Teo: curso.nota2Teo, nota3Teo: curso.nota3Teo, nota1Lab: curso.nota1Lab, nota2Lab: curso.nota2Lab, nota3Lab: curso.nota3Lab)
        if(state){
            cell.textLabel?.text = "✅ \(curso.nombre!)"
        }else{
            cell.textLabel?.text = "❎ \(curso.nombre!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let curso = cursos[indexPath.row]
        let state = verifyState(nota1Teo: curso.nota1Teo, nota2Teo: curso.nota2Teo, nota3Teo: curso.nota3Teo, nota1Lab: curso.nota1Lab, nota2Lab: curso.nota2Lab, nota3Lab: curso.nota3Lab)
        print(curso.nombre!)
        if(state){
            cell.backgroundColor = UIColor.green
        }else{
            cell.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func agregarCurso(_ sender: Any) {
        performSegue(withIdentifier: "segueAgregar", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let tarea = cursos[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(tarea)
            cursos.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        agregarCursos()
        tableView.reloadData()
    }
    
    func agregarCursos() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            cursos = try context.fetch(Curso.fetchRequest()) as! [Curso]
        }catch{
            print("Ocurrio un error")
        }
    }
    
    func verifyState(nota1Teo:Double,nota2Teo:Double,nota3Teo:Double,
                     nota1Lab:Double,nota2Lab:Double,nota3Lab:Double) -> Bool {
        var state:Bool = false
        let promTeo = ((nota1Teo+nota2Teo+nota3Teo)/3)*0.3
        let promLab = ((nota1Lab+nota2Lab+nota3Lab)/3)*0.7
        let promFinal = (promTeo+promLab)
        print(promFinal)
        if(promFinal >= 13){
            state = true
        }
        return state
    }
}

