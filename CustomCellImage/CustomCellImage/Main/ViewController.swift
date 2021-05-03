//
//  ViewController.swift
//  CustomCellImage
//
//  Created by Elard Huaraca on 2/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videos = createArray()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func createArray() -> [Video] {
        var temporally: [Video] = []
        let video1 = Video(image: UIImage(named: "Images/imagen1")!, title: "Torre de PC")
        let video2 = Video(image: UIImage(named: "Images/imagen2")!, title: "Monitor de PC")
        let video3 = Video(image: UIImage(named: "Images/imagen3")!, title: "Teclado de PC")
        let video4 = Video(image: UIImage(named: "Images/imagen4")!, title: "Mouse de PC")
        temporally.append(video1)
        temporally.append(video2)
        temporally.append(video3)
        temporally.append(video4)
        return temporally
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoTableViewCell
        let video = videos[indexPath.row]
        cell.setVideo(video: video)
        return cell
    }
}
