//
//  CalculatorDelegate.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 06/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import Foundation

protocol CalculatorDelegate: class {
    func calculationDidChange()
    func operatorDidChange(_ _operator: Operator?)
}
