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
    
    
    //MARK: - STREAK SECTION
    
    // get current day streak -> determined whether today step is 500 or less -> if yes than day streak + 1, if not than set current streak to 0
    // following lines will be executed every midnight
    @objc func addStreakNum() {
        let minimumRequiredStep = 500
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        formatter.timeZone = TimeZone.current
        
        // Check whether last data is exist
        if let lastData = allData.last {
            // Check whether amount of data is bigger than 1
            if allData.count > 1 {
                let formattedLastData = formatter.string(from: lastData.date)
                let formatterDateNow = formatter.string(from: Date())
                
                // Check whether last date of data stored in coredata is same with today's date
                if formattedLastData == formatterDateNow {
                    // Check whether yesterday's count step meet the minimum requirement
                    if allData[allData.count - 2].countSteps >= minimumRequiredStep {
                        udService.currentDayStreak += 1
                    } else {
                        udService.currentDayStreak = 0
                    }
                }
            }
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
    
    
    //MARK: - DETERMINED SECTION
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
    
    @objc func setDetermined() {
        udService.isDeterminedToday = false
        
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
    }
    
    func stepCounts(for days: AccomplishedDays) -> Int {
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
    
    func configureOlympic(_ ach: Achievement, status: AchievementStatus) {
        let olympicStatus = CoreDataFunction.getCategory(for: .olympic).isLocked
        
        if olympicStatus == false {
            
        }
    }
}
