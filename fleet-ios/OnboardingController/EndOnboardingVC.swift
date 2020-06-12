//
//  EndOnboardingVC.swift
//  fleet-ios
//
//  Created by Windy on 26/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import UserNotifications

class EndOnboardingVC: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var descriptionText: String = ""
    
    let hkService = HealthKitService.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = descriptionText
        
        let achievements = CoreDataFunction.retrieveAchievements(for: .streak)
        if achievements?.count == 0 {
            let arrayAchievement = achievementArray.flatMap { $0.map { $0 }}
            arrayAchievement.forEach { (achievement) in
                CoreDataFunction.saveAchievement(achievement: achievement)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func letsDoTapped(_ sender: UIButton) {
        
        UserDefaultServices.instance.hasLaunched = true
        
        //Ask some permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, err) in
            guard err == nil else {
                print(err!)
                return
            }
            
            if granted {
                print("Access granted")
            } else {
                print("Not granted")
            }
            
            self.hkService.authorizeHealthKit { (success, err) in
                if let error = err {
                    print(error)
                }
                if success {
                    self.hkService.getTodayStep { (step) in
                        UserDefaultServices.instance.currentStep = Int(step)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! UITabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                    
                    UserDefaultServices.instance.currentGoal = 500
                }
            }
        }
    }
}
