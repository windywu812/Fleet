//
//  ChartFuncion.swift
//  fleet-ios
//
//  Created by Windy on 30/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Charts
import UIKit

let barChart = BarChartView()

extension ProgressController: ChartViewDelegate {
    
    func sumStepEachMonth(_ month: Int) -> Double {
        Double(allData.filter {
            Calendar.current.component(.month, from: $0.date) == month + 1
        }.reduce(0, { $0 + $1.countSteps }))
    }
    
    func setChartWeekly(_ add: Int = 0) {
        
        var countSteps = [Int]()
        var targetSteps = [Int]()
        
        var countStepsEntry = [BarChartDataEntry]()
        var targetStepsEntry = [BarChartDataEntry]()
        
        countStepsEntry.removeAll()
        targetStepsEntry.removeAll()
        
        let groupedByWeek = Dictionary(grouping: allData, by: { $0.date.week })
        let groupedKey = groupedByWeek.keys.sorted()
        
        now += add
        
        if now >= Date().week {
            now = Date().week
        }
        
        if now <= groupedKey.first ?? 0 {
            now = groupedKey.first ?? 0
        }
        
        let myData = groupedByWeek[now]
        print(myData?.count)
        if myData?.count != 7 {

            let index = myData?.first!.date.weekDay ?? 0
            print(index)
            if index == 0 {
                return
            }
            
            for _ in 0..<index - 1 {
                countSteps.append(0)
                targetSteps.append(0)
            }

            myData?.forEach({
                countSteps.append($0.countSteps)
                targetSteps.append($0.targetSteps)
            })
            
        } else {
            myData?.forEach({
                countSteps.append($0.countSteps)
                targetSteps.append($0.targetSteps)
            })
        }
        
        print(countSteps)
//        print(targetSteps)
        
        // Comparison
        var countStepsBefore: [Int] = []
        let previousData = groupedByWeek[now - 1]
        previousData?.forEach({
            countStepsBefore.append($0.countSteps)
        })
        
        let avgSum = countSteps.reduce(0, { $0 + $1 }) / 7
        let avgPreviousSum = countStepsBefore.reduce(0, { $0 + $1 }) / 7
        
        let formatterWithoutYear = DateFormatter()
        formatterWithoutYear.dateFormat = "dd MMM"
        
        let formatterWithYear = DateFormatter()
        formatterWithYear.dateFormat = "dd MMM yyyy"
        
        dateLabel.text = "\(formatterWithoutYear.string(from: myData?.first?.date ?? Date())) - \(formatterWithYear.string(from: myData?.last?.date ?? Date()))"
        totalStepsWeekly.text = "\(countSteps.reduce(0, { $0 + $1 }))"
                
        if avgSum > avgPreviousSum {
            weeklySummary.text = "On average, this week's step count is more than last week"
        } else {
            weeklySummary.text = "On Average, last week’s step count was lower than two weeks ago."
        }
        
        
        for x in 0..<countSteps.count {
            // Insert count entry
            let countStepsData = BarChartDataEntry(x: Double(x), y: Double(countSteps[x]))
            countStepsEntry.append(countStepsData)
            
            // Insert target entry
            let targetStepsData = BarChartDataEntry(x: Double(x), y: Double(targetSteps[x]))
            targetStepsEntry.append(targetStepsData)
        }
                
        let countStepsDataSet = BarChartDataSet(entries: countStepsEntry, label: "Total Steps")
        countStepsDataSet.drawValuesEnabled = false
        countStepsDataSet.setColor(UIColor(named: "orange") ?? UIColor.orange)
        
        let targetStepsDataSet = BarChartDataSet(entries: targetStepsEntry, label: "Your Target")
        targetStepsDataSet.setColor(UIColor(named: "darkblue") ?? UIColor.blue)
        targetStepsDataSet.drawValuesEnabled = false
        
        let groupChartData = BarChartData(dataSets: [countStepsDataSet, targetStepsDataSet])
        groupChartData.notifyDataChanged()
        
        // Value
//        let groupSpace = 0.3
//        let barSpace = 0.05
//        let barWidth = 0.4
        let groupSpace = 0.2
        let barSpace = 0.05
        let barWidth = 0.35

        let groupspace = groupChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print(groupspace)
        print(groupspace * 7 / 2)
        // XAxis
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: Calendar.current.shortWeekdaySymbols)
        barChart.xAxis.axisMinimum = 0
        barChart.xAxis.axisMaximum = groupspace * 7 / 2
        barChart.xAxis.centerAxisLabelsEnabled = true
        barChart.xAxis.granularity = 1
        barChart.xAxis.drawGridLinesEnabled = false
        
        groupChartData.barWidth = barWidth
        groupChartData.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        groupChartData.notifyDataChanged()
        barChart.animate(yAxisDuration: 1, easingOption: .easeInCubic)
        barChart.data = groupChartData
        
    }
    
    func setChartAnually() {
        
        var countSteps: [Int] = []

        for x in 0...12 {
            countSteps.append(Int(sumStepEachMonth(x)))
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        dateLabel.text = formatter.string(from: Date())
        
        totalStepsWeekly.text = "\(countSteps.reduce(0, { $0 + $1 }))"
        weeklySummary.text = "On average, you walk about \(countSteps.reduce(0, { $0 + $1 }) / 12) each months"
        
        var totalStepsEntry = [BarChartDataEntry]()
        totalStepsEntry.removeAll()
        
        for x in 0..<countSteps.count {
            let totalStepsData = BarChartDataEntry(x: Double(x), y: Double(countSteps[x]))
            totalStepsEntry.append(totalStepsData)
        }
        
        let countStepsDataSet = BarChartDataSet(entries: totalStepsEntry)
        countStepsDataSet.setColor(UIColor.orange)
        countStepsDataSet.drawValuesEnabled = false
        countStepsDataSet.setColor(UIColor(named: "orange")!)
        
        let chartData = BarChartData(dataSet: countStepsDataSet)
        chartData.notifyDataChanged()
        
        barChart.xAxis.axisMinimum = -0.5
        barChart.xAxis.axisMaximum = 11.5
        barChart.xAxis.centerAxisLabelsEnabled = false
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: Calendar.current.shortMonthSymbols)
        barChart.animate(yAxisDuration: 1, easingOption: .easeInCubic)
        barChart.data = chartData
        
    }
    
}

let calender = Calendar.current

extension Date {
    var year: Int {
        return calender.component(.year, from: self)
    }
    var week: Int {
        return calender.component(.weekOfYear, from: self)
    }
    var weekAndYear: DateComponents {
        return calender.dateComponents([.weekOfYear, .year], from: self)
    }
    var weekDay: Int {
        return calender.component(.weekday, from: self)
    }
}
