//
//  FirstViewController.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 12/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import MapKit

class FleetController: UIViewController {
    
    
    @IBOutlet var groupButton: [UIButton]!
    @IBOutlet weak var goalLabel: UILabel!
    
    var isEdit: Bool = false
    var goal: Int = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        goalLabel.text = String(goal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        groupButton.forEach { (btn) in
            btn.isHidden = true
        }
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        isEdit.toggle()
        
        if isEdit {
            groupButton.forEach { (btn) in
                btn.isHidden = false
            }
            
            sender.setTitle("Done", for: .normal)
        } else {
            groupButton.forEach { (btn) in
                btn.isHidden = true
            }
            
            sender.setTitle("Edit", for: .normal)

        }
        
    }
    
    @IBAction func groupButton(_ sender: UIButton) {
        
        if sender.tag == 0 {
            goal -= 500
            if goal <= 0 {
                goal = 0
            }
            goalLabel.text = String(goal)
        } else {
            goal += 500
            goalLabel.text = String(goal)
        }
        
    }
}
