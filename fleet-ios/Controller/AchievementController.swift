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
    @IBOutlet weak var keepUpLabel: UILabel!
    
    private let service = UserDefaultServices.instance
    private var categoryArray = [Category]()
    private let achService = AchievementService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categoryArray = CoreDataFunction.getCategories()!
        
        let gestureRec = UITapGestureRecognizer(target: self, action:  #selector(goDetail))
        streakView.addGestureRecognizer(gestureRec)

    }
    
    @objc func goDetail() {
        performSegue(withIdentifier: K.Identifier.streakSegue, sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let currentStreak = service.currentDayStreak
        let noun = currentStreak > 1 ? "days streak" : "day streak"
        
        keepUpLabel.text = currentStreak < 1 ? "Let's Start!" : "Keep it up!"
        numStreakLbl.text = "\(currentStreak) \(noun)"
        
        achService.unlockConsistent()
        achService.unlockOlympic()
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
        } else {
            let alert = UIAlertController(title: "Sorry", message: "You need to conquer the previous achievement", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(alert, animated: true)
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
