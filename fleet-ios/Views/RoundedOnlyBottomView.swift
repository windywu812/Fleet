//
//  RoundedOnlyBottomView.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 19/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class RoundedOnlyBottomView: UIView {
    
    override func awakeFromNib() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.myView.frame
        rectShape.position = self.myView.center
        rectShape.path = UIBezierPath(roundedRect: self.myView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight , .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
        self.myView.layer.backgroundColor = UIColor.green.cgColor
        self.myView.layer.mask = rectShape
    }
}
