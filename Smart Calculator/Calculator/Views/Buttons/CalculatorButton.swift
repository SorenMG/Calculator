//
//  CalculatorButton.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 25/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton {
    
    // MARK: Properties
    public var type: CalculatorType!
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 30)
        self.setTitleColor(UIColor.buttonTextColor, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
