import UIKit

class ViewControllerCurso: UIViewController {

    @IBOutlet weak var InputFirstNote: UITextField!
    @IBOutlet weak var InputSecondNote: UITextField!
    @IBOutlet weak var InputThreeNote: UITextField!
    @IBOutlet weak var InputFourNote: UITextField!
    @IBOutlet weak var InputFirstLabNote: UITextField!
    @IBOutlet weak var InputSecondLabNote: UITextField!
    @IBOutlet weak var InputThreeLabNote: UITextField!
    @IBOutlet weak var InputFourLabNote: UITextField!
    @IBOutlet weak var InputFiveLabNote: UITextField!
    @IBOutlet weak var InputSixLabNote: UITextField!
    @IBOutlet weak var InputFinalNote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Promedio(_ sender: Any) {
        let not1Teo = Double(InputFirstNote.text!)!
        let not2Teo = Double(InputSecondNote.text!)!
        let not3Teo = Double(InputThreeNote.text!)!
        let not4Teo = Double(InputFourNote.text!)!
        let not1Lab = Double(InputFirstLabNote.text!)!
        let not2Lab = Double(InputSecondLabNote.text!)!
        let not3Lab = Double(InputThreeLabNote.text!)!
        let not4Lab = Double(InputFourLabNote.text!)!
        let not5Lab = Double(InputFiveLabNote.text!)!
        let not6Lab = Double(InputSixLabNote.text!)!
        let promTeo = ((not1Teo+not2Teo+not3Teo+not4Teo)/4) * 0.4
        let promLab = ((not1Lab+not2Lab+not3Lab+not4Lab+not5Lab+not6Lab)/6) * 0.6
        let promFinal = promTeo + promLab
        InputFinalNote.text = "\(promFinal)"
    }
}
