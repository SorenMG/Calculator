//
//  Double+Extensions.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 31/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import Foundation

extension Double {
    var clean: String {
        return self .truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
