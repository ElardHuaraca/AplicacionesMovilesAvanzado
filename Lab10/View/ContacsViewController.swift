//
//  ContacsViewController.swift
//  Lab10
//
//  Created by Elard Huaraca on 23/6/21.
//

import UIKit
import FirebaseDatabase

class ContacsViewController: UIViewController {

    @IBOutlet weak var contacTableView: UITableView!
    var contacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacTableView.dataSource = self
        contacTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Database.database().reference().child("usuarios").observe(.childAdded, with: {
            (snapchot) in
            let user = User(email: "", id: "", username: "", url: "")
            let value = snapchot.value as? NSDictionary
            user.username = value!["username"] as! String
            user.url = value!["url_photo"] as! String
            self.contacts.append(user)
            self.contacTableView.reloadData()
        })
    }
}

extension ContacsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = UITableViewCell()
        let contact = contacts[indexPath.row]
        cel.textLabel?.text = contact.username
        let url = URL(string: contact.url)
        let data = try? Data(contentsOf: url!)
        cel.imageView?.image = UIImage(data: data!)
        return cel
    }
}