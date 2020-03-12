//
//  CalculatorViewModel.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 31/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorViewModel {
    
    // MARK: Properties
    public var calculator = SmartCalculator()
    public weak var delegate: CalculatorViewModelDelegate?
    
    // Reactional properties
    var rx_calculation: BehaviorRelay<[CalculationStep]> = BehaviorRelay(value: [])
    
    // MARK: Initialization
    init() {
        calculator.delegate = self
    }
    
    // MARK: Methods
    public func handleButtonTap(_ type: CalculatorType) {
        if let number = type.number {
            if number == .comma {
                handleCommaTapped()
            }
            else {
                handleNumberTapped(number.rawValue)
            }
        }
        else if let operation = type.operation {
            handleOperatorTapped(operation)
        }
        else if let method = type.method {
            if method == .clear {
                handleClearTapped()
            }
            else if method == .invert {
                calculator.invertNumber()
            }
            else if method == .percent {
                handleButtonTap(CalculatorType(operation: .divide))
                handleButtonTap(CalculatorType(number: .one))
                handleButtonTap(CalculatorType(number: .zero))
                handleButtonTap(CalculatorType(number: .zero))
                handleButtonTap(CalculatorType(isEquals: true))
            }
            
        }
        else if type.isEquals {
            handleEqualsTapped()
        }
        
        delegate?.valuesChanged()
    }
    
    private func handleCommaTapped() {
        calculator.addDecimalMark()
    }
    
    private func handleEqualsTapped() {
        calculator.calculate()
    }
    
    private func handleClearTapped() {
        calculator.clear()
    }
    
    private func handleNumberTapped(_ number: Int) {
        calculator.appendValueToString(number)
    }
    
    private func handleOperatorTapped(_ _operator: Operator) {
        calculator.submitOperator(_operator)
    }
}

extension CalculatorViewModel: CalculatorDelegate {
    func operatorDidChange(_ _operator: Operator?) {}
    
    func calculationDidChange() {
        rx_calculation.accept(calculator.calculation.steps.reversed())
    }
}
