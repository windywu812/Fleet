//
//  FirstOnboradingViewController.swift
//  fleet-ios
//
//  Created by Windy on 15/06/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class FirstOnboradingViewController: UIViewController {

    @IBOutlet weak var disclamerPopUp: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurEffect)

        // Do any additional setup after loading the view.
        disclamerPopUp.layer.cornerRadius = 20
        disclamerPopUp.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.addSubview(disclamerPopUp)
        self.disclamerPopUp.center = view.center
        self.disclamerPopUp.alpha = 0
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.disclamerPopUp.alpha = 1
            self.disclamerPopUp.transform = .identity
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.disclamerPopUp.alpha = 0
            self.disclamerPopUp.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
            self.blurEffect.alpha = 0
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
