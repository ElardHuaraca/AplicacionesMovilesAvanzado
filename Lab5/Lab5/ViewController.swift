import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tareas:[Tarea] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let tarea = tareas[indexPath.row]
        if tarea.importante{
            cell.textLabel?.text = "❗️\(String(describing: tarea.nombre!))"
        }else{
            cell.textLabel?.text = tarea.nombre!
        }
        return cell
    }
    
    @IBAction func agregarTarea(_ sender: Any) {
        performSegue(withIdentifier: "agregarSegue", sender: nil)
    }
    
    func obetenerTareas(){
        let context	= (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            tareas = try context.fetch(Tarea.fetchRequest()) as! [Tarea]
        } catch  {
            print("Ha ocurrido un error")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tarea = tareas[indexPath.row]
        performSegue(withIdentifier: "tareaSeleccionadaSegue", sender: tarea)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tareaSeleccionadaSegue" {
            let siguienteVC = segue.destination as! TareaCompletadaViewController
            siguienteVC.tarea = (sender as! Tarea)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        obetenerTareas()
        tableView.reloadData()
    }
}

