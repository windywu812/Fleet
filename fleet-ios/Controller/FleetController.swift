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
    var goal: Int = 500
    var currentLevel: Int = 0
    var totalSteps = 10000
    
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
            currentLevel += 1
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(alert, animated: true)
            
            totalSteps = 0
            progressView.setProgress(0, animated: true)
        }

        
    }
    
    func setupMascot() {
        goalLabel.text = String(goal)
        mascotView.image = mascots[currentLevel].image
        levelLabel.text = mascots[currentLevel].id
        progressView.setProgress((Float(totalSteps) / Float(mascots[currentLevel].stepsToLvlUp)), animated: true)
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
