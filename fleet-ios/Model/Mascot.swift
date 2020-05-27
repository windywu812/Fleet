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

let level1 = Mascot(id: "Newbie", image: UIImage(named: "newbie")!, stepsToLvlUp: 10000)
let level2 = Mascot(id: "Rookie", image: UIImage(named: "rookie")!, stepsToLvlUp: 15000)
let level3 = Mascot(id: "Master", image: UIImage(named: "master")!, stepsToLvlUp: 25000)
let level4 = Mascot(id: "GrandMaster", image: UIImage(named: "grandMaster")!, stepsToLvlUp: 50000)
let level5 = Mascot(id: "Legend", image: UIImage(named: "legend")!, stepsToLvlUp: 100000)

let mascots = [level1, level2, level3, level4, level5]
