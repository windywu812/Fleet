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
    
    func setStreakComplete(_ ach: Achievement) {
        let currentDayStreak = udService.currentDayStreak
        let streakCount = udService.streakCount
        if currentDayStreak >= ach.progressTotal {
            ach.isComplete = true
        } else {
            ach.isComplete = false
        }
    }
    
    // configure which of determined achievements need to set completed base on determinedCount on user default
    func configureDetermined(_ achs: [Achievement]) -> [Achievement]? {
        var returnedAchs = [Achievement]()
        let determinedCount = udService.determinedCount
        
        let firstAchs = achs.prefix(determinedCount)
        let lastAchs = achs.suffix(achs.count - determinedCount)
        
        if udService.isDeterminedToday == false {
            firstAchs.forEach { (ach) in
                ach.isComplete = true
                returnedAchs.append(ach)
            }
            
            lastAchs.forEach { (ach) in
                returnedAchs.append(ach)
            }
            
            return returnedAchs
        } else {
            return nil
        }
    }
    
    func addDeterminedNum(ach: Achievement) {
        let currentStep = udService.currentStep
        
        if currentStep >= ach.progressTotal {
            udService.determinedCount += 1
        }
    }
    
    @objc func setDetermined() {
        udService.isDeterminedToday = false
    }
    
    func isTodayDeterminedComplete(_ ach: Achievement) -> Bool {
        return udService.currentStep >= ach.progressTotal
    }
    
    func unlockConsistent() {
        let determinedData = CoreDataFunction.retrieveAchievements(for: .determined)
        let currentDetermined = udService.determinedCount
        
        if currentDetermined >= determinedData!.count {
            CoreDataFunction.unlockCategory(for: .accomplished)
        }
    }
    
    func unlockOlympic() {
        let consistentData = CoreDataFunction.retrieveAchievements(for: .accomplished)
        let currentConsistent = udService.consistentCount
        
        if currentConsistent >= consistentData!.count {
            CoreDataFunction.unlockCategory(for: .olympic)
        }
    }
}
