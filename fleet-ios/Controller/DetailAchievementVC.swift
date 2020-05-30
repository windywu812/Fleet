//
//  DetailAchievementVC.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class DetailAchievementVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var category: Category?
    var achievement: [Achievement]!
    let udService = UserDefaultServices.instance
    
    var currentDeterminedCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AchievementCell", bundle: nil), forCellReuseIdentifier: K.Cell.achievementCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        category = achievement[0].category
        title = category?.name.rawValue
        
        currentDeterminedCount = udService.determinedCount
        
        if category?.name == .determined {
            udService.determinedCount = 4

            achievement = AchievementService.instance.configureDetermined(achievement)
            achievement.forEach { (ach) in
                print(ach.title)
                print(ach.isComplete)
                print("----------------------")
            }
        }
    }
}

extension DetailAchievementVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.achievementCell) as? AchievementCell else {return UITableViewCell()}
        
        let ach = achievement[indexPath.row]
        cell.configureCell(ach: ach)
        
        if category?.name == .determined {
            let currentStep = udService.currentStep
            if indexPath.row == currentDeterminedCount {
                cell.progress.setProgress(Float(currentStep)/Float(ach.progressTotal), animated: false)
            }
        }
        return cell
    }
    
    
}
