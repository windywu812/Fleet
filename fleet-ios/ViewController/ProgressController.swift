//
//  ProgressController.swift
//  fleet-ios
//
//  Created by Windy on 12/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import Charts

class ProgressController: UIViewController {
    
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var chartView: UIView!
    
    let barChart = BarChartView()
    
    // Dummy data
    let countSteps = [300, 430, 453, 224, 232, 543, 233]
    let targetSteps = [500, 500, 500, 500, 1000, 400, 300]
    
    let countStepsPerMonth = [1243, 2562, 2323, 3432, 1234, 3455, 2344, 5432, 1243, 4233, 3532, 5432]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setChartWeekly(countSteps, targetSteps)
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            setChartWeekly(countSteps, targetSteps)
        } else if sender.selectedSegmentIndex == 1{
            setChartAnually(countStepsPerMonth)
        }
    }
    
    func setupView() {
        
        topBackground.backgroundColor = .orange
        cardView.backgroundColor = .white
        chartView.backgroundColor = .white
        
        addShadow(cardView)
        addShadow(chartView)
        
        setUpChart()
                        
    }
    
    func addShadow(_ view: UIView) {
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
 
}

extension ProgressController: ChartViewDelegate {
    
    func setChartWeekly(_ countSteps: [Int], _ targetSteps: [Int]) {
                
        let dayName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        var countStepsEntry = [BarChartDataEntry]()
        var targetStepsEntry = [BarChartDataEntry]()
        
        countStepsEntry.removeAll()
        targetStepsEntry.removeAll()
    
        for x in 0..<countSteps.count {
            // Insert count entry
            let countStepsData = BarChartDataEntry(x: Double(x), y: Double(countSteps[x]))
            countStepsEntry.append(countStepsData)
            
            // Insert target entry
            let targetStepsData = BarChartDataEntry(x: Double(x), y: Double(targetSteps[x]))
            targetStepsEntry.append(targetStepsData)
        }
        
        let countStepsDataSet = BarChartDataSet(entries: countStepsEntry, label: "Total Steps")
        countStepsDataSet.setColor(.orange)
        countStepsDataSet.drawValuesEnabled = false
        
        let targetStepsDataSet = BarChartDataSet(entries: targetStepsEntry, label: "Your Target")
        targetStepsDataSet.setColor(.gray)
        targetStepsDataSet.drawValuesEnabled = false
        
        let groupChartData = BarChartData(dataSets: [countStepsDataSet, targetStepsDataSet])
        groupChartData.notifyDataChanged()
                
        // Value
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.4
        let groupspace = groupChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        
        // XAxis
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayName)
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
    
    func setChartAnually(_ countSteps: [Int]) {
        
        let monthName = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Des"]
        
        var totalStepsEntry = [BarChartDataEntry]()
        totalStepsEntry.removeAll()
        
        for x in 0..<countSteps.count {
            let totalStepsData = BarChartDataEntry(x: Double(x), y: Double(countSteps[x]))
            totalStepsEntry.append(totalStepsData)
        }
        
        let countStepsDataSet = BarChartDataSet(entries: totalStepsEntry)
        countStepsDataSet.setColor(UIColor.orange)
        countStepsDataSet.drawValuesEnabled = false
        
        let chartData = BarChartData(dataSet: countStepsDataSet)
        chartData.notifyDataChanged()

        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: monthName)
        barChart.animate(yAxisDuration: 1, easingOption: .easeInCubic)
        barChart.data = chartData
        
    }
        
    func setUpChart() {
                        
        barChart.delegate = self
        barChart.doubleTapToZoomEnabled = false
        view.addSubview(barChart)
        
        barChart.backgroundColor = .clear
        barChart.isUserInteractionEnabled = false
        
        // Grid
        barChart.rightAxis.enabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawGridLinesEnabled = false
        
        // Legend
        barChart.legend.horizontalAlignment = .center
        barChart.legend.enabled = false
        
        // Label
        barChart.leftAxis.labelFont = .systemFont(ofSize: 14)
        barChart.xAxis.labelFont = .systemFont(ofSize: 14)
        
        // Add some constraint
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 68).isActive = true
        barChart.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -16).isActive = true
        barChart.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 16).isActive = true
        barChart.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -16).isActive = true
        
        
    }
    
}
