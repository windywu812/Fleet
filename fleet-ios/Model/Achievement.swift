//
//  Achievement.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 27/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

class Achievement {
    var title: String
    var progressTotal: Int
    var category: Category
    var isComplete: Bool = false
    
    init(title: String, progressTotal: Int, category: Category) {
        self.title = title
        self.progressTotal = progressTotal
        self.category = category
    }
}
