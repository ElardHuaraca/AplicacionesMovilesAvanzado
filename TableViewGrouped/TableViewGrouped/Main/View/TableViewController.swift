//
//  TableViewController.swift
//  TableViewGrouped
//
//  Created by Elard Huaraca on 2/5/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var secciones: [Secciones] = ModeloDatos().obtenerSeccionesDesdeDatos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return secciones.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secciones[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secciones[section].cabecera
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = secciones[indexPath.section].items[indexPath.row]
        return cell
    }
}
