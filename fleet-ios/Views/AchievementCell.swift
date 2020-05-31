//
//  AchievementCell.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class AchievementCell: UITableViewCell {
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var button: UIButton!
    let achService = AchievementService.instance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    func configureCell(ach: Achievement) {
        txtTitle.text = ach.title

        let category = ach.category
        var percentage: Float = 0.0
        
        if category.name == .streak {
            achService.setStreakComplete(ach)
            percentage = achService.getStreakNum(for: ach.progressTotal)
        } 
        
        if ach.isComplete == true {
            progress.isHidden = true
        } else {
            progress.layer.cornerRadius = 2
            progress.setProgress(percentage, animated: false)
        }
    }
}
