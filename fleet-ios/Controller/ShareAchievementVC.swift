//
//  ShareAchievementVC.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 12/06/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class ShareAchievementVC: UIViewController {

    @IBOutlet weak var roundedView: RoundedView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblAchievement: UILabel!
    @IBOutlet weak var shareBtn: RoundedButton!
    
    var achievement: Achievement!
    var detailVC: DetailAchievementVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblCategory.text = "\(achievement.category.name.rawValue) Achievement"
        lblAchievement.text = "Successfully \(achievement.title)"
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        CoreDataFunction.updateAchievementStatus(achievement: achievement, status: .isFinished)

        detailVC?.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
