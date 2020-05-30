//
//  UserDefaultServices.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 28/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

class UserDefaultServices {
    static let instance = UserDefaultServices()
    
    private let def = UserDefaults.standard

    fileprivate let hasLaunchedKey = "hasLaunched"
    
    // For each day to be saved
    fileprivate let currentStepEachDayKey = "currentStepEachDay"
    fileprivate let currentGoalEachDayKey = "currentGoalEachDay"
    
    fileprivate let currentDayStreakKey = "currentDayStreak"
    
    // For Mascot
    fileprivate let currentLevelKey = "currentLevel"
    fileprivate let totalStepForNextLevelKey = "totalStepsForNextLevel"
    
    var hasLaunched: Bool {
        get {
            return def.bool(forKey: hasLaunchedKey)
        }
        set {
            def.set(newValue, forKey: hasLaunchedKey)
        }
    }
    
    // Each Day
    var currentStep: Int {
        get {
            return def.integer(forKey: currentStepEachDayKey)
        }
        set {
            def.set(newValue, forKey: currentStepEachDayKey)
        }
    }
    
    var currentGoal: Int {
        get {
            return def.integer(forKey: currentGoalEachDayKey)
        }
        set {
            def.set(newValue, forKey: currentGoalEachDayKey)
        }
    }
    
    var currentDayStreak: Int {
        get {
            return def.integer(forKey: currentDayStreakKey)
        }
        set {
            def.set(newValue, forKey: currentDayStreakKey)
        }
    }
    
    // For Mascot
    var currentLevel: Int {
        get {
            return def.integer(forKey: currentLevelKey)
        }
        set {
            def.set(newValue, forKey: currentLevelKey)
        }
    }
    
    var totalStepsForNextLevel: Int {
        get {
            return def.integer(forKey: totalStepForNextLevelKey)
        }
        set {
            def.set(newValue, forKey: totalStepForNextLevelKey)
        }
    }
    
    
}
