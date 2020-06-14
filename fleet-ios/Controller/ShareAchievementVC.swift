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
    @IBOutlet weak var doneBtn: RoundedButton!
    @IBOutlet weak var stackButton: UIStackView!
    @IBOutlet weak var visualView: UIVisualEffectView!
    
    var achievement: Achievement!
    var detailVC: DetailAchievementVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCategory.text = "\(achievement.category.name.rawValue) Achievement"
        lblAchievement.text = "Successfully \(achievement.title)"
        
    }
    
    @IBAction func doneBtnPressed(_ sender: RoundedButton) {
        CoreDataFunction.updateAchievementStatus(achievement: achievement, status: .isFinished)
        detailVC?.tableView.reloadData()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        shareAchievement()
    }
    
    func shareAchievement() {
        var img = UIImage()
        
        stackButton.isHidden = true
        visualView.isHidden = true
        
        let renderer = UIGraphicsImageRenderer(size: roundedView.bounds.size)
        let image = renderer.image { (ctx) in
            roundedView.drawHierarchy(in: roundedView.bounds, afterScreenUpdates: true)
        }
        
        img = image
        
        stackButton.isHidden = false
        visualView.isHidden = false
        
        let messageStr = "Go get your own achievement by download Fleet on the App Store"
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [img, messageStr], applicationActivities: nil)
        
        self.present(activityViewController, animated: true) {
            CoreDataFunction.updateAchievementStatus(achievement: self.achievement, status: .isFinished)
            self.detailVC?.tableView.reloadData()
        }
    }
}
