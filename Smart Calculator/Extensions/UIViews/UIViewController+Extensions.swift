//
//  UIViewController+Extensions.swift
//  Dating App
//
//  Created by Søren Møller Gade Hansen on 20/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        print("Added \(child)")
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        print("Removed \(parent!)")
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
