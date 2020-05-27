//
//  Dummies.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

private var determined = Category(name: "Determined", isLocked: false)
private var consistent = Category(name: "Consistent", isLocked: true)
private var olympic = Category(name: "Olympic", isLocked: true)
var categoryArray: [Category] = [determined, consistent, olympic]

let countSteps = [300, 430, 453, 224, 232, 543, 233]
let targetSteps = [500, 500, 500, 500, 1000, 400, 300]

let countStepsPerMonth = [1243, 2562, 2323, 3432, 1234, 3455, 2344, 5432, 1243, 4233, 3532, 5432]

private var streak = Category(name: "Day Streak", isLocked: false)
private var achStreak: [Achievement] = [
    Achievement(title: "10 Days Walk Streak", progressTotal: 10, category: streak),
    Achievement(title: "20 Days Walk Streak", progressTotal: 20, category: streak),
    Achievement(title: "40 Days Walk Streak", progressTotal: 40, category: streak),
    Achievement(title: "50 Days Walk Streak", progressTotal: 50, category: streak),
    Achievement(title: "70 Days Walk Streak", progressTotal: 70, category: streak),
    Achievement(title: "80 Days Walk Streak", progressTotal: 80, category: streak),
    Achievement(title: "90 Days Walk Streak", progressTotal: 90, category: streak)
]

private var achDetermined: [Achievement] = [
    Achievement(title: "Walk 750 steps in a day", progressTotal: 750, category: determined),
    Achievement(title: "Walk 1121 steps in a day", progressTotal: 1121, category: determined),
    Achievement(title: "Walk 1140 steps in a day", progressTotal: 1140, category: determined),
    Achievement(title: "Walk 1821 steps in a day", progressTotal: 1821, category: determined),
    Achievement(title: "Walk 2200 steps in a day", progressTotal: 2200, category: determined),
    Achievement(title: "Walk 2575 steps in a day", progressTotal: 2575, category: determined),
    Achievement(title: "Walk 3000 steps in a day", progressTotal: 3000, category: determined)
]

private var achConsistent: [Achievement] = [
    Achievement(title: "Walk 3000 steps for 7 days in a row", progressTotal: 21000, category: consistent),
    Achievement(title: "Walk 3000 steps for 21 days in a row", progressTotal: 63000, category: consistent),
    Achievement(title: "Walk 3500 steps for 30 days in a row", progressTotal: 105000, category: consistent)
]

private var achOlympic: [Achievement] = [
    Achievement(title: "Walk 10000 steps for 3 days in a row", progressTotal: 10000, category: olympic),
    Achievement(title: "Walk 15000 steps for 7 days in a row", progressTotal: 15000, category: olympic),
    Achievement(title: "Walk 17000 steps for a total of 25 times", progressTotal: 425000, category: olympic),
    Achievement(title: "Walk 20000 steps for 3 days in a row", progressTotal: 60000, category: olympic)
]

var achievementArray = [achDetermined, achConsistent, achOlympic, achStreak]
