//
//  CalculatorTypes.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 29/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import Foundation

struct CalculatorType {
    // MARK: Properties
    var operation: Operator?
    var number: Number?
    var method: Method?
    var isEquals: Bool = false
    
    // MARK: Initialization
    init(operation: Operator) {
        self.operation = operation
    }
    
    init(number: Number) {
        self.number = number
    }
    
    init(method: Method) {
        self.method = method
    }
    
    init(isEquals: Bool) {
        self.isEquals = isEquals
    }
}
