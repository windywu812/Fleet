//
//  AchievementService.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 30/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

class AchievementService {
    static let instance = AchievementService()
    
    fileprivate let udService = UserDefaultServices.instance
    
    // get current day streak -> determined whether today step is 500 or less -> if yes than day streak + 1, if not than set current streak to 0
    @objc func configureStreak() {
        let currentStep = udService.currentStep
        let minimumRequiredStep = 500
        
        if currentStep >= minimumRequiredStep {
            udService.currentDayStreak += 1
        } else {
            udService.currentDayStreak = 0
        }
    }
    
    func getStreakNum(for progressTotal: Int) -> Float {
        let progressTotal = Float(progressTotal)
        let currentDayStreak = Float(udService.currentDayStreak)
        
        return currentDayStreak/progressTotal
    }
    
    func setStreakComplete(_ ach: Achievement) {
        let currentDayStreak = udService.currentDayStreak

        if currentDayStreak >= ach.progressTotal {
            ach.isComplete = true
        } else {
            ach.isComplete = false
        }
    }
}
