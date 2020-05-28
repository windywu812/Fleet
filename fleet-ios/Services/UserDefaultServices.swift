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
    fileprivate let currentStepKey = "currentStep"
    
    var hasLaunched: Bool {
        get {
            return def.bool(forKey: hasLaunchedKey)
        }
        set {
            def.set(newValue, forKey: hasLaunchedKey)
        }
    }
    
    var currentStep: Int {
        get {
            return def.integer(forKey: currentStepKey)
        }
        set {
            def.set(newValue, forKey: currentStepKey)
        }
    }
    
}
