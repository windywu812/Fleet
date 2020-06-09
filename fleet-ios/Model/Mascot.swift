//
//  Mascot.swift
//  fleet-ios
//
//  Created by Windy on 27/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

struct Mascot {
    let id: String
    let image: UIImage
    let stepsToLvlUp: Int
}

let level1 = Mascot(id: "Newbie", image: UIImage(named: Level.level1.rawValue)!, stepsToLvlUp: 0)
let level2 = Mascot(id: "Rookie", image: UIImage(named: Level.level2.rawValue)!, stepsToLvlUp: 15000)
let level3 = Mascot(id: "Master", image: UIImage(named: Level.level3.rawValue)!, stepsToLvlUp: 25000)
let level4 = Mascot(id: "GrandMaster", image: UIImage(named: Level.level4.rawValue)!, stepsToLvlUp: 40000)
let level5 = Mascot(id: "Legend", image: UIImage(named: Level.level5.rawValue)!, stepsToLvlUp: 80000)

let mascots = [level1, level2, level3, level4, level5]
