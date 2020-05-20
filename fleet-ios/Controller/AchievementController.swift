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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension AchievementController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryAchievementCell else {return UITableViewCell()}
        
        let category = categoryArray[indexPath.row]
        cell.configureCell(category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categoryArray[indexPath.row]
        performSegue(withIdentifier: "toDetailAchievement", sender: category)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let category = sender as! Category
        
        if segue.identifier == "toDetailAchievement" {
            if let detailVC = segue.destination as? DetailAchievementVC {
                detailVC.category = category
            }
        }
    }
}
