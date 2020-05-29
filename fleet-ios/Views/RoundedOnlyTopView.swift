//
//  RoundedOnlyTopView.swift
//  fleet-ios
//
//  Created by Windy on 29/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedOnlyTopView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.clipsToBounds = true
    }

}
