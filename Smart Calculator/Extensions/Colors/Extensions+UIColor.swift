//
//  Extensions+UIColor.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 25/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }

    // Project colors
    // Background
    //    static let background = UIColor(r: 32, g: 33, b: 34)
    //    static let resultBackground = UIColor(r: 26, g: 27, b: 28)
    static let buttonViewBackground     = UIColor(r: 239, g: 241, b: 243)
//    static let background               = UIColor(r: 26, g: 27, b: 28)
    static let background               = UIColor.buttonViewBackground
    
    // Text color
    static let buttonTextColor          = UIColor.background
    static let resultTextColor          = UIColor.black
    static let equalsButtonTextColor    = UIColor.white
    static let operatorButtonTextColor  = UIColor.white
    static let methodButtonTextColor    = UIColor.black
    static let numberButtonTextColor    = UIColor.black
    static let resultListTextColor      = UIColor.init(r: 160, g: 161, b: 162)
    
    // View colors
    static let separatorColor           = UIColor.background
    static let buttonTintColor          = UIColor(r: 107, g: 107, b: 107)
    static let returnButtonColor        = UIColor.buttonViewBackground
    static let equalsButtonColor        = UIColor.init(r: 250, g: 155, b: 24)
    static let operatorButtonColor      = UIColor.equalsButtonColor
    static let methodButtonColor        = UIColor.init(r: 200, g: 201, b: 202)
    static let numberButtonColor        = UIColor.white
    static let buttonSeparatorColor     = UIColor.black
    
}
