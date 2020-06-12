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
    @IBOutlet weak var imgAchievement: UIImageView!
    
    let achService = AchievementService.instance
    var achievement: Achievement?
    var delegate: AchievementCompleteDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        progress.layer.cornerRadius = 2
    }
    
    func configureCell(ach: Achievement, delegate: AchievementCompleteDelegate) {
        self.delegate = delegate
        achievement = ach
        txtTitle.text = ach.title
        
        let category = ach.category
        var percentage: Float = 0.0
        
        if category.name == .streak {
            percentage = achService.getStreakNum(for: ach.progressTotal)
        } else if category.name == .determined {
            if achService.isTodayDeterminedComplete(ach) {
                progress.isHidden = true
                imgAchievement.image = UIImage(named: "ach-complete")
            } else {
                imgAchievement.image = UIImage(named: "ach-incomplete")
            }
            return
        }
        
        if ach.isComplete == AchievementStatus.isFinished {
            progress.isHidden = true
            imgAchievement.image = UIImage(named: "ach-complete")
            
            button.isHidden = false
            button.setTitleColor(UIColor.systemGreen, for: .normal)
            button.layer.borderColor = UIColor.systemGreen.cgColor
            button.layer.borderWidth = 1
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
        } else if ach.isComplete == AchievementStatus.notConfirmed {
            progress.isHidden = true
            imgAchievement.image = UIImage(named: "ach-incomplete")
            
            button.isHidden = false
            button.setTitleColor(UIColor.systemOrange, for: .normal)
            button.layer.borderColor = UIColor.systemOrange.cgColor
            button.layer.borderWidth = 2
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            
        } else {
            progress.layer.cornerRadius = 2
            progress.setProgress(percentage, animated: false)
            
            imgAchievement.image = UIImage(named: "ach-incomplete")
            
            button.isHidden = true
        }
    }
    
    @IBAction func btnCompletePressed(_ sender: UIButton) {
        if achievement?.isComplete == .notConfirmed {
            delegate?.shareAchievementComplete(achievement!)
        }
    }
    //    @objc func changeToComplete() {
//        CoreDataFunction.updateAchievementStatus(achievement: achievement!, status: .isFinished)
//        configureCell(ach: achievement!)
//    }
}
