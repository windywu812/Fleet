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
    
    //MARK: - GENERAL ACHIEVEMENT SECTION
    func configureAchievements(for category: Category) {
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
    }
    
    
    //MARK: - STREAK SECTION
    func addStreakNum() {
        let minimumRequiredStep = 500
        var count = 0
        for data in allData {
            if data.countSteps >= minimumRequiredStep {
                count += 1
            } else {
                count = 0
            }
        }
        udService.currentDayStreak = count
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
    
    
    //MARK: - DETERMINED SECTION
    // configure which of determined achievements need to set completed base on determinedCount on user default
    func configureDetermined(_ ach: Achievement, status: AchievementStatus) {
        if udService.isDeterminedToday == false {
            let currentStep = udService.currentStep
            if currentStep >= ach.progressTotal {
                CoreDataFunction.updateAchievementStatus(achievement: ach, status: .notConfirmed)
                udService.isDeterminedToday = true
                
                setDeterminedDate()
            }
        }
    }
    
    func setDetermined() {
        setupDeterminedStatus()
    
        let determinedAchs = CoreDataFunction.retrieveAchievements(for: .determined)
        let determinedCount = udService.determinedCount
        
        if determinedAchs!.count < determinedCount {
            if determinedAchs![determinedCount].isComplete != .notFinished {
                udService.determinedCount += 1
            }
        }
        
        if udService.determinedCount == determinedAchs!.count {
            udService.accomplishedUnlockedDate = Date()
            udService.determinedCount += 1
        }
    }
    
    func setDeterminedDate(date: Date = Date()) {
        var arrayDate = udService.determinedDateArray
        arrayDate.append(Date())
        udService.determinedDateArray = arrayDate
    }
    
    func setupDeterminedStatus() {
        let arrayDate = udService.determinedDateArray
        if arrayDate.last == Date() {
            udService.isDeterminedToday = true
        } else {
            udService.isDeterminedToday = false
        }
    }
    
    //MARK: - ACCOMPLISHED SECTION
    func unlockAccomplished() {
        let determinedData = CoreDataFunction.retrieveAchievements(for: .determined)
        let currentDetermined = udService.determinedCount
        
        if currentDetermined >= determinedData!.count {
            CoreDataFunction.unlockCategory(for: .accomplished)
        }
    }
    
    func configureAccomplished() {
        let accomplishedData = CoreDataFunction.retrieveAchievements(for: .accomplished)!
        let accomplishedStatus = CoreDataFunction.getCategory(for: .accomplished).isLocked
        
        if accomplishedStatus == false {
            if accomplishedData[0].isComplete == .notFinished {
                if stepCounts(for: .seven) >= accomplishedData[0].progressTotal {
                    CoreDataFunction.updateAchievementStatus(achievement: accomplishedData[0], status: .notConfirmed)
                    udService.accomplishedCount += 1
                }
            }
            
            if accomplishedData[1].isComplete == .notFinished {
                if stepCounts(for: .twentyOne) >= accomplishedData[1].progressTotal {
                    CoreDataFunction.updateAchievementStatus(achievement: accomplishedData[1], status: .notConfirmed)
                    udService.accomplishedCount += 1
                }
            }
            
            if accomplishedData[2].isComplete == .notFinished {
                if stepCounts(for: .thirty) >= accomplishedData[2].progressTotal {
                    CoreDataFunction.updateAchievementStatus(achievement: accomplishedData[2], status: .notConfirmed)
                    udService.accomplishedCount += 1
                }
            }
        }
        
        if udService.accomplishedCount >= CoreDataFunction.retrieveAchievements(for: .accomplished)!.count {
            udService.olympicUnlockedDate = Date()
        }
    }
    
    func stepCounts(for days: AchievementCompletedDays) -> Int {
        let accomplishedUnlockedDate = udService.accomplishedUnlockedDate
        
        var arrayAllData = [DayModel]()
        allData.forEach { (model) in
            if model.date >= accomplishedUnlockedDate {
                arrayAllData.append(model)
            }
        }
        
        let data = Array(arrayAllData.suffix(days.rawValue))
        
        var stepCount = 0
        data.forEach { (model) in
            stepCount += model.countSteps
        }
        
        return stepCount
    }
    
    //MARK: - OLYMPIC SECTION
    func unlockOlympic() {
        let consistentData = CoreDataFunction.retrieveAchievements(for: .accomplished)
        let currentConsistent = udService.accomplishedCount
        
        if currentConsistent >= consistentData!.count {
            CoreDataFunction.unlockCategory(for: .olympic)
        }
    }
    
    func configureOlympic() {
        let olympicData = CoreDataFunction.retrieveAchievements(for: .olympic)!
        let olympicStatus = CoreDataFunction.getCategory(for: .olympic).isLocked
        
        if olympicStatus == false {
            if olympicData[0].isComplete == .notFinished {
                if stepCounts(for: .three) >= olympicData[0].progressTotal {
                    CoreDataFunction.updateAchievementStatus(achievement: olympicData[0], status: .notConfirmed)
                    udService.olympicCount += 1
                }
            }
            
            if olympicData[1].isComplete == .notFinished {
                if stepCounts(for: .seven) >= olympicData[1].progressTotal {
                    CoreDataFunction.updateAchievementStatus(achievement: olympicData[1], status: .notConfirmed)
                    udService.olympicCount += 1
                }
            }
            
            if olympicData[3].isComplete == .notFinished {
                if stepCounts(for: .three) >= olympicData[3].progressTotal {
                    CoreDataFunction.updateAchievementStatus(achievement: olympicData[3], status: .notConfirmed)
                    udService.olympicCount += 1
                }
            }
            
            if olympicData[2].isComplete == .notFinished {
                if udService.olympic25Times >= 25 {
                    CoreDataFunction.updateAchievementStatus(achievement: olympicData[2], status: .notConfirmed)
                    udService.olympicCount += 1
                }
            }
        }
    }
    
    func olympic25Count() -> Int {
        var count = 0
        
        var dataAfterUnlocked = [DayModel]()
        allData.forEach { (data) in
            if data.date >= udService.olympicUnlockedDate {
                dataAfterUnlocked.append(data)
            }
        }
        
        dataAfterUnlocked.forEach { (data) in
            if data.countSteps >= 17000 {
                count += 1
            }
        }
        
        return count
    }
}
