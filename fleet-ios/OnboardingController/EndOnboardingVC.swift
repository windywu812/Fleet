//
//  EndOnboardingVC.swift
//  fleet-ios
//
//  Created by Windy on 26/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class EndOnboardingVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var descriptionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = descriptionText
        // Do any additional setup after loading the view.
    }
    
    @IBAction func letsDoTapped(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
        
        //Ask some permission
    }

}
