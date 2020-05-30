import UIKit

class LevelInfoVC: UIViewController {
    
    @IBOutlet var mascotView: [UIImageView]!
    
    let services = UserDefaultServices.instance

    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch services.currentLevel {
        case 1:
            mascotView[1].image = UIImage(named: "rookie")
        case 2:
            mascotView[1].image = UIImage(named: "rookie")
            mascotView[2].image =
                UIImage(named: "master")
        case 3:
            mascotView[1].image = UIImage(named: "rookie")
            mascotView[2].image =
                UIImage(named: "master")
            mascotView[3].image = UIImage(named: "grandMaster")
        case 4:
            mascotView[1].image = UIImage(named: "rookie")
            mascotView[2].image =
                UIImage(named: "master")
            mascotView[3].image = UIImage(named: "grandMaster")
            mascotView[4].image = UIImage(named: "legend")
        default:
            return
        }
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

