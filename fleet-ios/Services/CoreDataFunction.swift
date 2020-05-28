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

    static func retrieveAllData() -> [DayModel] {

        var daySummaries = [DayModel]()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
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
    
    static func retrievePreviousDay(interval: Int = -7) -> [DayModel] {
        
        var daySummaries = [DayModel]()
        
        let calender = Calendar.current
        var now = Date()
        var passedDay = calender.date(byAdding: .day, value: interval, to: now) ?? Date()
        var startDate = calender.startOfDay(for: passedDay)
        
        if interval != -7 {
            now = startDate
            passedDay = calender.date(byAdding: .day, value: interval, to: now) ?? Date()
            startDate = calender.startOfDay(for: passedDay)

        }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let appDelegate = appDelegate {
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityDay)
                        
            fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date < &@)", startDate as CVarArg, now as CVarArg)
            
            do {
                let result = try manageContext.fetch(fetchRequest) as? [NSManagedObject]
                
                result?.forEach{ daySummary in
                    daySummaries.append(DayModel(
                        id: daySummary.value(forKey: K.Core.id) as! UUID,
                        countSteps: daySummary.value(forKey: K.Core.totalStep) as! Int,
                        targetSteps: daySummary.value(forKey: K.Core.targetStep) as! Int,
                        date: daySummary.value(forKey: K.Core.date) as! Date
                        )
                    )
                }
                
            } catch let err {
                print(err)
            }
        }
        
        return daySummaries
    }
    
    static func saveData(id: UUID, totalStep: Int, targetStep: Int, date: Date) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
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
        
}

