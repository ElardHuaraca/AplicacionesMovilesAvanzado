//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Elard Huaraca on 25/4/21.
//

import UIKit
import AVKit

class SoundViewController: UIViewController {

    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnPlay: UIButton!
    var audioRecorder : AVAudioRecorder?
    var audioPlay : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyBoard()
        setUpRecord()
        btnPlay.isEnabled = false
        btnPlay.setTitle("Disabled", for: .normal)
        btnPlay.backgroundColor = .blue
    }
    
    @IBAction func recordPlay(_ sender: Any) {
        if audioRecorder!.isRecording{
            audioRecorder?.stop()
            btnRecord.setTitle("Record", for: .normal)
            btnPlay.isEnabled = true
            btnPlay.setTitle("Play", for: .normal)
            btnPlay.backgroundColor = .cyan
        }else{
            audioRecorder?.record()
            btnRecord.setTitle("Stop", for: .normal	)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        do {
            try audioPlay = AVAudioPlayer(contentsOf: audioURL!)
            audioPlay?.play()
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        print(audioURL!)
        print(txtName.text!)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let sound = Sound(context:context)
        sound.name = txtName.text
        sound.audio = NSData(contentsOf: audioURL!) as Data?
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func setUpRecord() {
        do {
            //create the session audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            //create path
            let basePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponent = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponent)
            print("*****************")
            print(audioURL!)
            print("*****************")
            //option on record audio
            var setting : [String:AnyObject] = [:]
            setting[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            setting[AVSampleRateKey] = 44100.0 as AnyObject?
            setting[AVNumberOfChannelsKey] = 2 as AnyObject?
            //create Object To Audio Record
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: setting)
            audioRecorder?.prepareToRecord()
        } catch let error as NSError{
            print(error)
        }
    }
}
