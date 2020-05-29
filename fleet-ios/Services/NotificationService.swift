//
//  NotificationService.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 29/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

class NotificationService {
    static let instance = NotificationService()
    
    func scheduleDailyReminder() {
        let calendar = Calendar.current

        // Daily Reminder Time
        let now = Date()
        let date = calendar.date(
            bySettingHour: 23,
            minute: 52,
            second: 0,
            of: now)!

        let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(triggerNotification), userInfo: nil, repeats: false)

        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func triggerNotification(title: String, body: String) {
        
    }
}
