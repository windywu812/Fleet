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
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
        self.layer.mask = rectShape
    }
}
