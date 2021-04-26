//
//  ViewController.swift
//  SoundBoard
//
//  Created by Elard Huaraca on 22/4/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var sounds : [Sound] = []
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyBoard()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let sound = sounds[indexPath.row]
        cell.textLabel?.text = sound.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        do {
            audioPlayer = try AVAudioPlayer(data: sound.audio!)
            audioPlayer?.play()
        } catch {}
        tableView.deselectRow(at: indexPath,animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let sound = sounds[indexPath.row]
            let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(sound)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                sounds = try context.fetch(Sound.fetchRequest())
                tableView.reloadData()
            } catch {}
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            sounds = try context.fetch(Sound.fetchRequest())
            tableView.reloadData()
        } catch  {
        }
    }
}


