//
//  CategoryAchievementCell.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class CategoryAchievementCell: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgLock: UIImageView!
    
    func configureCell(_ category: Category) {
        lblCategory.text = category.name
        
        if category.isLocked == true {
            imgLock.isHidden = false
        } else {
            imgLock.isHidden = true
        }
    }
    
}

