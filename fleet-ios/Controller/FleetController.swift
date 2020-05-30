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
    @IBOutlet weak var goalLabel: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var mascotView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var todayStepLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    var isEdit: Bool = false
    
    let service = UserDefaultServices.instance
    let hkService = HealthKitService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
        todayStepLabel.text = String(describing: service.currentStep)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        groupButton.forEach { (btn) in
            btn.isHidden = true
        }
        
        goalLabel.isUserInteractionEnabled = false
        setupMascot()
        checkProgress()
        
        // Configure Streak to be run every midnight
        NotificationCenter.default.addObserver(self, selector: #selector(AchievementService.instance.addStreakNum), name: .NSCalendarDayChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AchievementService.instance.setDetermined), name: .NSCalendarDayChanged, object: nil)
    }
    
    func checkProgress() {
        
        if progressView.progress >= 1 {
            service.currentLevel += 1
            
            service.totalStepsForNextLevel = 0
            progressView.setProgress(0, animated: false)
        }
    }
    
    func setupMascot() {
        let currentStep = service.currentStep
        
        goalLabel.text = String(service.currentGoal)
        mascotView.image = mascots[service.currentLevel].image
        levelLabel.text = mascots[service.currentLevel].id
        
        let remainStep = mascots[service.currentLevel + 1].stepsToLvlUp - currentStep
        progressLabel.text = "\(remainStep) steps left to level up"
        
        progressView.setProgress((Float(currentStep) / Float(mascots[service.currentLevel].stepsToLvlUp)), animated: false)
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        isEdit.toggle()
        
        if isEdit {
            groupButton.forEach { (btn) in
                btn.isHidden = false
            }
            goalLabel.isUserInteractionEnabled = true
            sender.setTitle("Done", for: .normal)
        } else {
            groupButton.forEach { (btn) in
                btn.isHidden = true
            }
            goalLabel.isUserInteractionEnabled = false
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

extension FleetController: UITextFieldDelegate {
    
    func setTextField() {
        goalLabel.delegate = self
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        self.view.frame.origin.y = 0 - keyboardSize.height
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        service.currentGoal = Int(goalLabel.text ?? "") ?? 0
        
        print(service.currentGoal)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}
