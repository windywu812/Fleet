//
//  Enums.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 30/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

enum Level: String {
    case level1 = "newbie"
    case level2 = "rookie"
    case level3 = "master"
    case level4 = "grandMaster"
    case level5 = "legend"
}

enum CategoryAchievement: String {
    case streak = "Day Streak"
    case determined = "Determined"
    case accomplished = "Accomplished"
    case olympic = "Olympic"
}

enum AchievementStatus: Int {
    case notFinished = 0
    case notConfirmed = 1
    case isFinished = 2
}

enum AccomplishedDays: Int {
    case seven = 7
    case twentyOne = 21
    case thirty = 30
}
