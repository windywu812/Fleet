//
//  Dummies.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

struct cat {
    static var determined = Category(name: .determined, subtitle: "Walk 750-3000 steps in 7 days", descCell: "Everyday you'll have target to achieve for Fleety grow faster in this achievement", isLocked: false)
    static var accomplished = Category(name: .accomplished, subtitle: "Do it streak for 7 days, 21 days and 30 days", descCell: "Complete Determined to unlock this mission", isLocked: true)
    static var olympic = Category(name: .olympic, subtitle: "Walk more than 10.000 steps streak", descCell: "Complete Accomplished to unlock this mission", isLocked: true)
    
    static var streak = Category(name: .streak, subtitle: "Walk with minimum 500 steps a day to get a streak!", descCell: "", isLocked: false)
}

var categoryArray: [Category] = [cat.determined, cat.accomplished, cat.olympic]


private var achStreak: [Achievement] = [
    Achievement(title: "10 Days Walk Streak", progressTotal: 10, category: cat.streak, isComplete: .notFinished),
    Achievement(title: "20 Days Walk Streak", progressTotal: 20, category: cat.streak, isComplete: .notFinished),
    Achievement(title: "40 Days Walk Streak", progressTotal: 40, category: cat.streak, isComplete: .notFinished),
    Achievement(title: "50 Days Walk Streak", progressTotal: 50, category: cat.streak, isComplete: .notFinished),
    Achievement(title: "70 Days Walk Streak", progressTotal: 70, category: cat.streak, isComplete: .notFinished),
    Achievement(title: "80 Days Walk Streak", progressTotal: 80, category: cat.streak, isComplete: .notFinished),
    Achievement(title: "90 Days Walk Streak", progressTotal: 90, category: cat.streak, isComplete: .notFinished)
]

private var achDetermined: [Achievement] = [
    Achievement(title: "Walk 750 steps in day 1", progressTotal: 750, category: cat.determined, isComplete: .notFinished),
    Achievement(title: "Walk 1121 steps in day 2", progressTotal: 1121, category: cat.determined, isComplete: .notFinished),
    Achievement(title: "Walk 1140 steps in day 3", progressTotal: 1140, category: cat.determined, isComplete: .notFinished),
    Achievement(title: "Walk 1821 steps in day 4", progressTotal: 1821, category: cat.determined, isComplete: .notFinished),
    Achievement(title: "Walk 2200 steps in day 5", progressTotal: 2200, category: cat.determined, isComplete: .notFinished),
    Achievement(title: "Walk 2575 steps in day 6", progressTotal: 2575, category: cat.determined, isComplete: .notFinished),
    Achievement(title: "Walk 3000 steps in day 7", progressTotal: 3000, category: cat.determined, isComplete: .notFinished)
]

private var achAccomplished: [Achievement] = [
    Achievement(title: "Walk 3000 steps for 7 days in a row", progressTotal: 21000, category: cat.accomplished, isComplete: .notFinished),
    Achievement(title: "Walk 3000 steps for 21 days in a row", progressTotal: 63000, category: cat.accomplished, isComplete: .notFinished),
    Achievement(title: "Walk 3500 steps for 30 days in a row", progressTotal: 105000, category: cat.accomplished, isComplete: .notFinished)
]

private var achOlympic: [Achievement] = [
    Achievement(title: "Walk 10000 steps for 3 days in a row", progressTotal: 10000, category: cat.olympic, isComplete: .notFinished),
    Achievement(title: "Walk 15000 steps for 7 days in a row", progressTotal: 15000, category: cat.olympic, isComplete: .notFinished),
    Achievement(title: "Walk 17000 steps for a total of 25 times", progressTotal: 425000, category: cat.olympic, isComplete: .notFinished),
    Achievement(title: "Walk 20000 steps for 3 days in a row", progressTotal: 60000, category: cat.olympic, isComplete: .notFinished)
]

var achievementArray = [achDetermined, achAccomplished, achOlympic, achStreak]

var funFact = [
    "Did you know? It takes approximately 200 muscles to take a single step when running!",
    "Did you know? Walking with music boosts your performance by 15%! Try it!",
    "Did you know? Theoretically, you could run for 3 days nonstop with your current energy!",
    "Did you know? Over a billion pair of shoes are sold every year. Should you get one too?",
    "Did you know? Only 14% of the world’s runners start running because of weight problems. But I doubt it..",
    "Did you know? Around 2.182 marathons are listed all over the world in 2018, why don’t you try one?",
    "Did you know? 75% of runners have had an injury related to running in the past 12 months! Be careful!",
    "Did you know? Experts say that jogging for 30 minutes every day shows proven health benefits!",
    "Did you know? Working out helps your social skills. Chicks digs joggers!",
    "Did you know? Humans outrun almost all animals in long distance marathons. Fleety is faster, though!",
    "Did you know? You should not drink before you jog, a good 8 oz. 5 minutes prior should do the trick.",
    "Did you know? Short jogs can increase your productivity at work.",
    "Did you know? Jogs can increase your brains functionality. Such as your vision and hearing.",
    "Did you know? A Japanese runner set a record for the longest marathon ever which he finished in 54 years and 8 months."
]
