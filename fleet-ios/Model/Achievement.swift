//
//  Achievement.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 27/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

struct Achievement {
    var title: String
    var progressTotal: Int
    var progressCurrent: Int = 0
    var category: Category
    var isComplete: Bool = false
    
    mutating func setComplete() {
        if progressTotal == progressCurrent {
            self.isComplete = true
        }
    }
}
