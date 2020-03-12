//
//  SmartCalculator.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 15/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import Foundation

class SmartCalculator: Calculator {
    
    weak var delegate: CalculatorDelegate?
    var calculation: Calculation = Calculation() {
        didSet {
            delegate?.calculationDidChange()
        }
    }
    override var submittedOperator: Operator? {
        didSet {
            delegate?.operatorDidChange(submittedOperator)
        }
    }
    var shouldCalculate: Bool {
        get {
            if self.newValue != "0" && self.submittedOperator != nil {
                return true
            }
            return false
        }
    }
    
    override var oldValue: Double? {
        didSet {
            if calculation.initialValue == nil {
                calculation.initialValue = oldValue
            }
        }
    }
    
    override func calculate() {
        // Save step
        if shouldCalculate {
            guard let calculatedOperator = self.submittedOperator else { return }
            guard let value = Double(self.newValue) else { return }
            addStep(value, calculatedOperator)
        }
        super.calculate()
    }
    
    override func submitOperator(_ calculatorOperator: Operator) {
        super.submitOperator(calculatorOperator)
    }
    
    private func addStep(_ value: Double, _ operation: Operator) {
        let step = CalculationStep(_operator: operation, value: value)
        calculation.steps.append(step)
    }
    
    override func clear() {
        super.clear()
        calculation = Calculation()
    }
}
