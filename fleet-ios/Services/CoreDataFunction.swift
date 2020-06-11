//
//  CoreData.swift
//  fleet-ios
//
//  Created by Windy on 20/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//
//
import UIKit
import CoreData

class CoreDataFunction {
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    static func retrieveAllData() -> [DayModel] {
        
        var daySummaries = [DayModel]()
        if let appDelegate = appDelegate {
            
            let manageContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityDay)
            
            do {
                let result = try manageContext.fetch(fetchRequest) as? [NSManagedObject]
                
                result?.forEach { daySummary in
                    
                    daySummaries.append(DayModel(
                        id: daySummary.value(forKey: K.Core.id) as! UUID,
                        countSteps: daySummary.value(forKey: K.Core.totalStep) as! Int,
                        targetSteps: daySummary.value(forKey: K.Core.targetStep) as! Int,
                        date: daySummary.value(forKey: K.Core.date) as! Date
                        )
                    )
                }
                
            } catch let err {
                print("Failed to load data, \(err)")
            }
        }
        return daySummaries
    }
    
    static func saveData(id: UUID, totalStep: Int, targetStep: Int, date: Date) {
        if let appDelegate = appDelegate {
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: K.Core.entityDay, in: managedContext) else { return }
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(id, forKey: K.Core.id)
            insert.setValue(totalStep, forKey: K.Core.totalStep)
            insert.setValue(targetStep, forKey: K.Core.targetStep)
            insert.setValue(date, forKey: K.Core.date)
            
            do {
                try managedContext.save()
            } catch let err {
                print(err)
            }
            
        }
    }
    
    static func updateData(totalStep: Int, targetStep: Int, date: Date) {
        if let appDelegate = appDelegate {
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityDay)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.date) > %@ AND \(K.Core.date) < %@", Date().startOfDay as CVarArg, Date().endOfDay as CVarArg )
            
            do {
                let fetch = try manageContext.fetch(fetchRequest)
                
                if fetch.isEmpty {
                    return
                }
                
                let dataToUpdate = fetch[0] as! NSManagedObject
                
                dataToUpdate.setValue(totalStep, forKey: K.Core.totalStep)
                dataToUpdate.setValue(targetStep, forKey: K.Core.targetStep)
                dataToUpdate.setValue(date, forKey: K.Core.date)
                
                try manageContext.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    static func saveAchievement(achievement: Achievement) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: K.Core.entityAchievement, in: managedContext) else {return}
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(achievement.title, forKey: K.Core.title)
            insert.setValue(achievement.progressTotal, forKey: K.Core.progressTotal)
            insert.setValue(achievement.category.name.rawValue, forKey: K.Core.category)
            insert.setValue(achievement.isComplete, forKey: K.Core.isFinished)
            
            do {
                try managedContext.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    static func retrieveAchievements(for category: CategoryAchievement) -> [Achievement]? {
        var achievements = [Achievement]()
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityAchievement)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.category) = %@", category.rawValue)
            
            do {
                let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                
                result?.forEach { achievement in
                    let selectedCategory = getCategoryFromString(value: achievement.value(forKey: K.Core.category) as! String)
                    achievements.append(
                        Achievement(
                            title: achievement.value(forKey: K.Core.title) as! String,
                            progressTotal: achievement.value(forKey: K.Core.progressTotal) as! Int,
                            category: selectedCategory)
                    )
                }
            } catch let err {
                print("Failed to load data, \(err)")
            }
        }
        
        return achievements
    }
    
    static func updateAchievementisFinished(achievement: Achievement) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityAchievement)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.title) = $!", achievement.title)
            
            do {
                let fetch = try managedContext.fetch(fetchRequest)
                
                if fetch.isEmpty {return}
                
                let achToUpdate = fetch[0] as! NSManagedObject
                
                achToUpdate.setValue(true, forKey: K.Core.isFinished)
                
                try managedContext.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    private static func getCategoryFromString(value: String) -> Category {
        switch value {
        case CategoryAchievement.determined.rawValue:
            return cat.determined
        case CategoryAchievement.consistent.rawValue:
            return cat.consistent
        case CategoryAchievement.olympic.rawValue:
            return cat.olympic
        default:
            return cat.streak
        }
    }
}

