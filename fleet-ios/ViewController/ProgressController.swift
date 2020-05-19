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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }
    
    func setupView() {
        
        topBackground.backgroundColor = .orange
        cardView.backgroundColor = .white
        chartView.backgroundColor = .white
        
        addShadow(cardView)
        addShadow(chartView)
                
    }
    
    func addShadow(_ view: UIView) {
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
}
