//
//  Calculator.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 05/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import Foundation

class Calculator {
    
    var newValue: String = "0"
    var oldValue: Double?
    var result: Double?
    var submittedOperator: Operator?
    
    func submitOperator(_ calculatorOperator: Operator) {
        if oldValue == nil {
            switchNewValueToOldValue()
        } else if newValue != "0" {
            calculate()
        }
        submittedOperator = calculatorOperator
    }
    
    func appendValueToString(_ value: Int) {
        if oldValue != nil && submittedOperator == nil { return }
        
        // If default value override
        if self.newValue == "0" {
            self.newValue = String(value)
            return
        }
        
        let newString = self.newValue + String(value)
        self.newValue = newString
    }
    
    func addDecimalMark() {
        if oldValue != nil && submittedOperator == nil { return }
        if !newValue.contains(".") {
            newValue += "."
        }
    }
    
    func invertNumber() {
        if let index = newValue.firstIndex(of: "-") {
            newValue.remove(at: index)
            return
        }
        newValue.insert("-", at: newValue.startIndex)
    }
    
    func calculate() {
        guard let calculatedOperator = self.submittedOperator else { return }
        guard let oldValue = self.oldValue else { return }
        guard let newValue = Double(self.newValue) else { return }
        var calculatedValue: Double!
        switch calculatedOperator {
        case .addition:
            calculatedValue = oldValue + newValue
        case .subtraction:
            calculatedValue = oldValue - newValue
        case .divide:
            calculatedValue = oldValue / newValue
        case .multiply:
            calculatedValue = oldValue * newValue
        }
        self.oldValue = calculatedValue
        self.newValue = "0"
        self.submittedOperator = nil
    }
    
    private func switchNewValueToOldValue() {
        guard let value = Double(newValue) else { fatalError("Cannot convert string to double") }
        self.oldValue = value
        self.newValue = "0"
    }
    
    public func clear() {
        newValue = "0"
        oldValue = nil
        result = nil
        submittedOperator = nil
    }
}
