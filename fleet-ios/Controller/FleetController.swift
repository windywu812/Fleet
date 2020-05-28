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
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var mascotView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var isEdit: Bool = false
    
    // Dummy test data
    let service = UserDefaultServices.instance
    

    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    override func viewDidAppear(_ animated: Bool) {
        groupButton.forEach { (btn) in
            btn.isHidden = true
        }
        
        setupMascot()
        checkProgress()
    }
    
    func checkProgress() {
        
        if progressView.progress >= 1 {
            service.currentLevel += 1
            
            service.totalStepsForNextLevel = 0
            progressView.setProgress(0, animated: true)
        }
    }
    
    func setupMascot() {
        goalLabel.text = String(service.currentGoal)
        mascotView.image = mascots[service.currentLevel].image
        levelLabel.text = mascots[service.currentLevel].id
        progressView.setProgress((Float(service.totalStepsForNextLevel) / Float(mascots[service.currentLevel].stepsToLvlUp)), animated: true)
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
            service.currentGoal -= 500
            if service.currentGoal <= 0 {
                service.currentGoal = 0
            }
            goalLabel.text = String(service.currentGoal)
            
        } else {
            service.currentGoal += 500
            goalLabel.text = String(service.currentGoal)
        }
    }
    
}
