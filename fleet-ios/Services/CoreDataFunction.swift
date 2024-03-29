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
    
    //MARK: - PROGRESS'S FUNCTIONS
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
    
    //MARK: - ACHIEVEMENT'S FUNCTIONS
    static func saveAchievement(achievement: Achievement) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: K.Core.entityAchievement, in: managedContext) else {return}
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(achievement.title, forKey: K.Core.title)
            insert.setValue(achievement.progressTotal, forKey: K.Core.progressTotal)
            insert.setValue(achievement.category.name.rawValue, forKey: K.Core.category)
            insert.setValue(achievement.isComplete.rawValue, forKey: K.Core.isFinished)
            
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
                    let selectedStatus = getStatusFromInt(value: achievement.value(forKey: K.Core.isFinished) as! Int)
                    achievements.append(
                        Achievement(
                            title: achievement.value(forKey: K.Core.title) as! String,
                            progressTotal: achievement.value(forKey: K.Core.progressTotal) as! Int,
                            category: selectedCategory,
                            isComplete: selectedStatus)
                    )
                }
            } catch let err {
                print("Failed to load data, \(err)")
            }
        }
        
        return achievements
    }
    
    static func updateAchievementStatus(achievement: Achievement, status: AchievementStatus) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityAchievement)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.title) = %@", achievement.title)
            
            do {
                let fetch = try managedContext.fetch(fetchRequest)
                let achToUpdate = fetch[0] as! NSManagedObject
                
                achToUpdate.setValue(status.rawValue, forKey: K.Core.isFinished)
                
                try managedContext.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    private static func getStatusFromInt(value: Int) -> AchievementStatus {
        switch value {
        case AchievementStatus.notConfirmed.rawValue:
            return AchievementStatus.notConfirmed
        case AchievementStatus.isFinished.rawValue:
            return AchievementStatus.isFinished
        default:
            return AchievementStatus.notFinished
        }
    }
    
    private static func getCategoryFromString(value: String) -> Category {
        switch value {
        case CategoryAchievement.determined.rawValue:
            return getCategory(for: .determined)
        case CategoryAchievement.accomplished.rawValue:
            return getCategory(for: .accomplished)
        case CategoryAchievement.olympic.rawValue:
            return getCategory(for: .olympic)
        default:
            return cat.streak
        }
    }
    
    //MARK: - CATEGORY'S FUNCTIONS
    static func saveCategory(category: Category) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: K.Core.entityCategory, in: managedContext) else {return}
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(category.name.rawValue, forKey: K.Core.catName)
            insert.setValue(category.subtitle, forKey: K.Core.catSubtitle)
            insert.setValue(category.descCell, forKey: K.Core.catDescCell)
            insert.setValue(category.isLocked, forKey: K.Core.catIsLocked)
            
            do {
                try managedContext.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    static func getCategories() -> [Category]? {
        var categories = [Category]()
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityCategory)
            
            do {
                let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                
                result?.forEach { category in
                    let selectedCategory = getCategoryAchievementFromString(value: category.value(forKey: K.Core.catName) as! String)
                    categories.append(
                        Category(
                            name: selectedCategory,
                            subtitle: category.value(forKey: K.Core.catSubtitle) as! String,
                            descCell: category.value(forKey: K.Core.catDescCell) as! String,
                            isLocked: category.value(forKey: K.Core.catIsLocked) as! Bool
                        )
                    )
                }
            } catch let err {
                print("Failed to load data, \(err)")
            }
        }
        
        return categories
    }
    
    static func getCategory(for name: CategoryAchievement) -> Category {
        var category: Category?
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityCategory)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.catName) = %@", name.rawValue)
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                
                if let resultCategory = result[0] as? NSManagedObject {
                    let selectedCategory = getCategoryAchievementFromString(value: resultCategory.value(forKey: K.Core.catName) as! String)
                    category = Category(
                        name: selectedCategory,
                        subtitle: resultCategory.value(forKey: K.Core.catSubtitle) as! String,
                        descCell: resultCategory.value(forKey: K.Core.catDescCell) as! String,
                        isLocked: resultCategory.value(forKey: K.Core.catIsLocked) as! Bool
                    )
                }
            } catch let err {
                print("Failed to load data, \(err)")
            }
        }
        
        return category!
    }
    
    static func unlockCategory(for category: CategoryAchievement) {
        var updatedDescCell = ""
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityCategory)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.catName) = %@", category.rawValue)
            
            do {
                let fetch = try managedContext.fetch(fetchRequest)
                
                if fetch.isEmpty {return}
                
                let achToUpdate = fetch[0] as! NSManagedObject
                
                achToUpdate.setValue(false, forKey: K.Core.catIsLocked)
                
                if category == .accomplished {
                    updatedDescCell = "In this achievement you should do it streak for 7 days, 21 days and 30 days"
                } else if category == .olympic {
                    updatedDescCell = "Bigger things are waiting you here for the growth of Fleety!"
                }
                achToUpdate.setValue(updatedDescCell, forKey: K.Core.catDescCell)
                
                try managedContext.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    static func getCategoryAchievementFromString(value: String) -> CategoryAchievement {
        switch value {
        case CategoryAchievement.determined.rawValue:
            return CategoryAchievement.determined
        case CategoryAchievement.accomplished.rawValue:
            return CategoryAchievement.accomplished
        default:
            return CategoryAchievement.olympic
            
        }
    }
    
    static func saveOrUpdateData() {
        let services = UserDefaultServices.instance
        
        if let date = CoreDataFunction.retrieveAllData().last?.date {
            if date > Date().startOfDay && date < Date().endOfDay {
                CoreDataFunction.updateData(totalStep: services.currentStep, targetStep: services.currentGoal, date: Date())
            } else {
                CoreDataFunction.saveData(id: UUID(), totalStep: services.currentStep, targetStep: services.currentGoal, date: Date())
            }
        } else {
            CoreDataFunction.saveData(id: UUID(), totalStep: services.currentStep, targetStep: services.currentGoal, date: Date())
        }
    }
}

