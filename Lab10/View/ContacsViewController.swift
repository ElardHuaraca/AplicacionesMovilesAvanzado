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
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacTableView.dataSource = self
        contacTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Database.database().reference().child("usuarios").observe(.childAdded, with: {
            (snapchot) in
            let user = Contact()
            let value = snapchot.value as? NSDictionary
            user.username = value!["username"] as! String
            user.url_image = value!["url_photo"] as! String
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
        if(contact.url_image != ""){
            let url = URL(string: contact.url_image)
            let data = try? Data(contentsOf: url!)
            cel.imageView?.image = UIImage(data: data!)
            cel.imageView?.layer.cornerRadius = (cel.imageView?.frame.size.width)! / 2
            cel.imageView?.clipsToBounds = true
            cel.layoutIfNeeded()
        }else{
            cel.imageView?.image = UIImage(named: "user")
        }
        return cel
    }
}
