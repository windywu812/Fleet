//
//  NotificationService.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 29/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationService {
    static let instance = NotificationService()
    
    func scheduleReminder(time: TimeNotif) {
        var components = DateComponents()
        switch time {
        case .morning:
            components.hour = 6
            triggerNotification(title: "Morning Reminder", body: "It's a new day, let's set your daily target!", date: components)
            break
        case .night:
            components.hour = 19
            triggerNotification(title: "Night Reminder", body: "Its been a while, Go take a look your weekly report", date: components)
            break
        }
    }
    
    func triggerNotification(title: String, body: String, date: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .defaultCritical
        content.body = body
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: body, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil{
                print("Something went wrong")
            }
        })
    }
    
    enum TimeNotif {
        case morning
        case night
    }
}
