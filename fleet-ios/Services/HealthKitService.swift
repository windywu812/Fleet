//
//  HealthKitService.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 29/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitService: HKHealthStore {
    static let instance = HealthKitService()
    
    private enum HealthkitAuthError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitAuthError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard let steps = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(false, HealthkitAuthError.dataTypeNotAvailable)
            return
        }
       
        //3. Prepare a list of types you want HealthKit to read and write
        let healthKitTypesToRead: Set<HKObjectType> = [steps]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    func getTodayStep(completion: @escaping (_ stepCount: Double) -> Void) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) // The type of data we are requesting
        
        let calendar = NSCalendar.current
        let interval = NSDateComponents()
        interval.day = 1
        
        var anchorComponents = calendar.dateComponents([.day , .month , .year], from: NSDate() as Date)
        anchorComponents.hour = 0
        let anchorDate = calendar.date(from: anchorComponents)
        
        let stepsQuery = HKStatisticsCollectionQuery(quantityType: type!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: interval as DateComponents)
        
        stepsQuery.initialResultsHandler = {query, results, error in
            let endDate = NSDate()
            
            var totalSteps = 0.0
            let startDate = calendar.date(byAdding: .day, value: 0, to: endDate as Date)
            if let myResults = results{  myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                print(statistics)
                if let quantity = statistics.sumQuantity(){
                    totalSteps = quantity.doubleValue(for: HKUnit.count())
                    completion(totalSteps)
                }
                }
            } else {
                // mostly not executed
                completion(totalSteps)
            }
        }
        HKHealthStore().execute(stepsQuery)
    }
}
