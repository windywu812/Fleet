//
//  SecondViewController.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 12/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class AchievementController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numStreakLbl: UILabel!
    @IBOutlet weak var imgMascot: UIImageView!
    @IBOutlet weak var streakView: RoundedView!
    
    private let service = UserDefaultServices.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let gestureRec = UITapGestureRecognizer(target: self, action:  #selector(goDetail))
        streakView.addGestureRecognizer(gestureRec)

        // Dummy to test logic for streak achievement
        UserDefaultServices.instance.currentDayStreak = 2
    
    }
    
    @objc func goDetail() {
        performSegue(withIdentifier: K.Identifier.streakSegue, sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let currentStreak = service.currentDayStreak
        let noun = currentStreak > 1 ? "days streak" : "day streak"
        
        numStreakLbl.text = "\(currentStreak) \(noun)"
    }
}

extension AchievementController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.categoryCell) as? CategoryAchievementCell else {return UITableViewCell()}
        
        let category = categoryArray[indexPath.row]
        cell.configureCell(category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categoryArray[indexPath.row]
        
        if !category.isLocked {
            performSegue(withIdentifier: K.Identifier.toDetailSegue, sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Identifier.toDetailSegue {
            let indexPath = sender as! IndexPath
            let achievement = achievementArray[indexPath.row]
            
            if let detailVC = segue.destination as? DetailAchievementVC {
                detailVC.achievement = achievement
            }
        } else {
            if let detailVC = segue.destination as? DetailAchievementVC {
                detailVC.achievement = achievementArray[3]
            }
        }
    }
}
