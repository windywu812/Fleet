//
//  Constans.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 28/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

struct K {
    struct Core {
        static let entityDay = "DaySummary"
        static let id = "id"
        static let totalStep = "totalStep"
        static let targetStep = "targetStep"
        static let date = "date"
        
        static let entityAchievement = "AchEntity"
        static let title = "title"
        static let progressTotal = "progressTotal"
        static let category = "category"
        static let isFinished = "isFinished"
    }
    
    struct Identifier {
        static let streakSegue = "streakSegue"
        static let toDetailSegue = "toDetailAchievement"
    }
    
    struct Cell {
        static let categoryCell = "categoryCell"
        static let achievementCell = "achievementCell"
    }
}
