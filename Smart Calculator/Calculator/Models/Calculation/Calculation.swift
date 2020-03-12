//
//  Calculation.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 31/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import Foundation

struct Calculation {
    // MARK: Properties
    var initialValue: Double?
    var steps: Array<CalculationStep> = [CalculationStep]()
    
    // MARK: Initialization
    init(initialValue: Double? = nil, steps: Array<CalculationStep> = [CalculationStep]()) {
        self.initialValue = initialValue
        self.steps = steps
    }
}
