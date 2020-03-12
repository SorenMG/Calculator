/*
 
 Calculator
 Input:
    String: "22.3"
    OR
    *, /, -, +
 
 OUTPUT:
    Calculation
 
 
*/


import UIKit

enum Operator {
    case divide
    case multiply
    case subtraction
    case addition
}


// Initial Calculator class
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
        // If default value override
        if self.newValue == "0" {
            self.newValue = String(value)
            return
        }
        
        let newString = self.newValue + String(value)
        self.newValue = newString
    }
    
    func addDecimalMark() {
        if !newValue.contains(".") {
            newValue += "."
        }
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
        
        print(calculatedValue)
    }
    
    private func switchNewValueToOldValue() {
        guard let value = Double(newValue) else { fatalError("Cannot convert string to double") }
        self.oldValue = value
        self.newValue = "0"
    }
}

// Save sequences of user input
class SmartCalculator: Calculator {
    
    var calculation = Calculation()
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
        let step = OperationStep(calculationOperator: operation, value: value)
        calculation.operationSteps.append(step)
    }
    
}

struct Calculation {
    var initialValue: Double?
    var operationSteps = [OperationStep]()
}

struct OperationStep {
    var calculationOperator: Operator
    var value: Double
}

let smartCalculator = SmartCalculator()
smartCalculator.appendValueToString(50)
// Submitted operator are nil
smartCalculator.submitOperator(.addition)

smartCalculator.appendValueToString(10)
// Are not nil now
smartCalculator.submitOperator(.multiply)
smartCalculator.submitOperator(.divide)

smartCalculator.appendValueToString(30)

smartCalculator.submitOperator(.subtraction)
smartCalculator.calculate()
