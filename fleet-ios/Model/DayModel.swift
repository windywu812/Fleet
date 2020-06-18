//
//  Day.swift
//  fleet-ios
//
//  Created by Windy on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

struct DayModel {
    var id = UUID()
    var countSteps: Int
    var targetSteps: Int
    var date: Date   
}

var allData = CoreDataFunction.retrieveAllData()

var now = Date().week
