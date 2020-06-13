//
//  DetailAchievementVC.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class DetailAchievementVC: UIViewController, AchievementCompleteDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category?
    var achievements = [Achievement]()
    let udService = UserDefaultServices.instance
    let service = AchievementService.instance
    
    @IBOutlet weak var detailLbl: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AchievementCell", bundle: nil), forCellReuseIdentifier: K.Cell.achievementCell)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = category?.name.rawValue
        detailLbl.text = category?.subtitle
        
        achievements = service.configureAchievements(for: category!)
    }
    
    func shareAchievementComplete(_ achievement: Achievement) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "ShareAchievementVC") as! ShareAchievementVC
        shareVC.modalTransitionStyle = .crossDissolve
        shareVC.achievement = achievement
        shareVC.detailVC = self
        present(shareVC, animated: true, completion: nil)
    }
}

extension DetailAchievementVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.achievementCell) as? AchievementCell else {return UITableViewCell()}
        
        let ach = achievements[indexPath.row]
        cell.configureCell(ach: ach, delegate: self)
        
        if category?.name == .determined {
            let currentStep = udService.currentStep
            if indexPath.row == udService.determinedCount {
                if udService.isDeterminedToday == false {
                    cell.progress.setProgress(Float(currentStep)/Float(ach.progressTotal), animated: false)
                }
            }
        }
        return cell
    }
}
