//
//  OnboardingVC.swift
//  fleet-ios
//
//  Created by Windy on 26/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func noTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "yesNo", sender: sender)
        descriptionLabel.text = "Fleety believes in you. Together, we will lead you into a healthy lifestyle!"
    }
    
    @IBAction func yesTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "yesNo", sender: sender)
        descriptionLabel.text = "Great! Together, we will help you create a healthier lifestyle."
    }
    
    @IBAction func letDoItTapped(_ sender: UIButton) {
    
    }
    
}
