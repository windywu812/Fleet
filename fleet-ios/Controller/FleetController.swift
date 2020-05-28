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
    
    var isEdit: Bool = false
    
    let service = UserDefaultServices.instance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        groupButton.forEach { (btn) in
            btn.isHidden = true
        }
        
        goalLabel.isUserInteractionEnabled = false
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
