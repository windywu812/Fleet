//
//  Category.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

class Category {
    var name: CategoryAchievement
    var isLocked: Bool
    
    init(name: CategoryAchievement, isLocked: Bool) {
        self.name = name
        self.isLocked = isLocked
    }
}


