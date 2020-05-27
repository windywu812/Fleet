//
//  Dummies.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

private var category1 = Category(name: "Determined", isLocked: false)
private var category2 = Category(name: "Consistent", isLocked: true)
private var category3 = Category(name: "Olympic", isLocked: true)
var categoryArray: [Category] = [category1, category2, category3]

let countSteps = [300, 430, 453, 224, 232, 543, 233]
let targetSteps = [500, 500, 500, 500, 1000, 400, 300]

let countStepsPerMonth = [1243, 2562, 2323, 3432, 1234, 3455, 2344, 5432, 1243, 4233, 3532, 5432]
