//
//  OnboardingVC.swift
//  fleet-ios
//
//  Created by Windy on 26/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet var groupBtn: [UIButton]!
    
    var yes: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func noTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "yesNo", sender: sender)
    }
    
    @IBAction func yesTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "yesNo", sender: sender)
        yes.toggle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yesNo" {
            let vc = segue.destination as! EndOnboardingVC
            if yes {
                vc.descriptionText = "Great! Together, we will help you create a healthier lifestyle."
            } else {
                vc.descriptionText = "Fleety believes in you. Together, we will lead you into a healthy lifestyle!"
            }
            
        }
    }
    
}
