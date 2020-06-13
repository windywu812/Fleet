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
    // following lines will be executed every midnight
    @objc func addStreakNum() {
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
    
    func setStreakComplete(_ ach: Achievement, status: AchievementStatus) {
        let currentDayStreak = udService.currentDayStreak
        if currentDayStreak >= ach.progressTotal {
            CoreDataFunction.updateAchievementStatus(achievement: ach, status: status)
        }
    }
    
    // configure which of determined achievements need to set completed base on determinedCount on user default
    func configureDetermined(_ ach: Achievement, status: AchievementStatus) {
        if udService.isDeterminedToday == false {
            let currentStep = udService.currentStep
            if currentStep >= ach.progressTotal {
                CoreDataFunction.updateAchievementStatus(achievement: ach, status: .notConfirmed)
                udService.isDeterminedToday = true
            }
        }
    }
    
    func unlockAccomplished() {
        let determinedData = CoreDataFunction.retrieveAchievements(for: .determined)
        let currentDetermined = udService.determinedCount
        
        if currentDetermined >= determinedData!.count {
            CoreDataFunction.unlockCategory(for: .accomplished)
        }
    }
    
    func unlockOlympic() {
        let consistentData = CoreDataFunction.retrieveAchievements(for: .accomplished)
        let currentConsistent = udService.accomplishedCount
        
        if currentConsistent >= consistentData!.count {
            CoreDataFunction.unlockCategory(for: .olympic)
        }
    }
    
    func configureAchievements(for category: Category) -> [Achievement] {
        let achievements = CoreDataFunction.retrieveAchievements(for: category.name)!
        
        if category.name == .determined {
            if udService.determinedCount < achievements.count {
                let determinedToday = achievements[udService.determinedCount]
                if determinedToday.isComplete == .notFinished {
                    configureDetermined(determinedToday, status: .notConfirmed)
                }
            }
        } else if category.name == .streak {
            achievements.forEach { (achievement) in
                if achievement.isComplete == .notFinished {
                    setStreakComplete(achievement, status: .notConfirmed)
                }
            }
        }
        
        return CoreDataFunction.retrieveAchievements(for: category.name)!
    }
}
