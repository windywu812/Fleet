//
//  FirstViewController.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 12/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation

class FleetController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var groupButton: [UIButton]!
    @IBOutlet weak var goalLabel: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var mascotView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var todayStepLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnVoiceOver: UIButton!
    
    var isEdit: Bool = false
    var remainStep = 99999

    var speechSynthesizer = AVSpeechSynthesizer()

    let service = UserDefaultServices.instance
    let hkService = HealthKitService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
        progressView.transform = CGAffineTransform(scaleX: 1, y: 3)
     
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        speechSynthesizer.delegate = self

        if let date = CoreDataFunction.retrieveAllData().last?.date {
            if date > Date().startOfDay && date < Date().endOfDay {
                CoreDataFunction.updateData(totalStep: service.currentStep, targetStep: service.currentGoal, date: Date())
            } else {
                CoreDataFunction.saveData(id: UUID(), totalStep: service.currentStep, targetStep: service.currentGoal, date: Date())
            }
        } else {
            CoreDataFunction.saveData(id: UUID(), totalStep: service.currentStep, targetStep: service.currentGoal, date: Date())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        NotificationService.instance.scheduleReminder(time: .morning)
        NotificationService.instance.scheduleReminder(time: .night)
        
        hkService.getTodayStep { (step) in
            self.service.currentStep = Int(step)
        }
        
        todayStepLabel.text = String(describing: service.currentStep)
        factLabel.text = funFact.randomElement()
        
        groupButton.forEach { (btn) in
            btn.isHidden = true
        }
        
        goalLabel.isUserInteractionEnabled = false
        
        setupMascot()
        checkProgress()

        NotificationCenter.default.addObserver(self, selector: #selector(AchievementService.instance.addStreakNum), name: .NSCalendarDayChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AchievementService.instance.setDetermined), name: .NSCalendarDayChanged, object: nil)
    }
    
    func checkProgress() {
        if progressView.progress >= 1 {
            service.currentLevel += 1
            service.totalStepsForNextLevel = 0
            print("Level: \(service.currentLevel)")
            progressLabel.text = "Fleety ready to upgrade"
            btnInfo.setImage(UIImage(systemName: "arrowtriangle.up.circle"), for: .normal)
            
            btnInfo.removeTarget(self, action: #selector(toInfoVC), for: .touchUpInside)
            btnInfo.addTarget(self, action: #selector(upgradeLevel), for: .touchUpInside)
            
            progressView.setProgress(0, animated: false)
        }
    }
    
    func setupMascot() {
        
        service.totalStepsForNextLevel = allData.map({ $0.countSteps }).reduce(0, { $0 + $1 })
        
        let currentStep = service.totalStepsForNextLevel - mascots[service.currentLevel].stepsToLvlUp
        
        goalLabel.text = String(service.currentGoal)
        mascotView.image = mascots[service.currentLevel].image
        levelLabel.text = mascots[service.currentLevel].id
        
        if service.currentLevel < 4 {
            remainStep = mascots[service.currentLevel + 1].stepsToLvlUp - currentStep
        }
        
        btnInfo.setImage(UIImage(systemName: "info.circle"), for: .normal)
        btnInfo.removeTarget(self, action: #selector(upgradeLevel), for: .touchUpInside)
        btnInfo.addTarget(self, action: #selector(toInfoVC), for: .touchUpInside)
        
        progressLabel.text = "\(remainStep) steps left to level up"
        progressView.setProgress((Float(currentStep) / Float(mascots[service.currentLevel + 1].stepsToLvlUp)), animated: false)
        
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
    
    @objc func toInfoVC() {
        performSegue(withIdentifier: "toLevelInfo", sender: nil)
    }
    
    @objc func upgradeLevel() {
        // LevelUpVC
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: "LevelUpVC") as! LevelUpVC
        popupVC.modalPresentationStyle = .popover
        popupVC.preferredContentSize = CGSize(width: 300, height: 300)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.fleetVC = self
        popupVC.nextLevel = service.currentLevel + 1
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func btnVoiceOverPressed(_ sender: Any) {
        synthesizeSpeech(from: factLabel.text!)
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

extension FleetController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        btnVoiceOver.isEnabled = false
        btnVoiceOver.alpha = 0.5
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        btnVoiceOver.isEnabled = true
        btnVoiceOver.alpha = 1
    }
    
    func synthesizeSpeech(from string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
}
