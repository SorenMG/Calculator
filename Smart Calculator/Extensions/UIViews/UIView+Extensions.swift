//
//  UIView+Extensions.swift
//  Dating App
//
//  Created by Søren Møller Gade Hansen on 23/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

extension UIView {
    
    fileprivate var supview: UIView {
        get {
            guard let supView = self.superview else { assertionFailure("Could not find superview"); return UIView() }
            return supView
        }
    }
    
    // MARK: Fill Views
    func fillSuperview(inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: supview.leftAnchor, constant: inset.left),
            self.rightAnchor.constraint(equalTo: supview.rightAnchor, constant: inset.right * -1),
            self.topAnchor.constraint(equalTo: supview.topAnchor, constant: inset.top),
            self.bottomAnchor.constraint(equalTo: supview.bottomAnchor, constant: inset.bottom * -1)
        ])
    }
    
    
    func fillView(_ view: UIView, inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: -inset.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom),
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -inset.left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: inset.right)
        ])
    }
    
    // MARK: Placing views
    func centerToSuperview() {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: self.supview.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: supview.centerYAnchor)
        ])
    }
    
    func centerXToSuperView() {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: supview.centerXAnchor)
        ])
    }
    
    func centerYToSuperView() {
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: supview.centerYAnchor)
        ])
    }
    
    func bind(attributes: [NSLayoutConstraint.Attribute], to view: UIView, attributes viewAttributes: [NSLayoutConstraint.Attribute]) {
        for (index, attribute) in attributes.enumerated() {
            bind(attribute: attribute, to: view, attribute: viewAttributes[index])
        }
    }
    
    func bind(attribute: NSLayoutConstraint.Attribute, to view: UIView, attribute attributeView: NSLayoutConstraint.Attribute) {
        createLayoutConstraint(attribute: attribute, to: view, attribute: attributeView).isActive = true
    }
        
    func createLayoutConstraint(attribute: NSLayoutConstraint.Attribute, to view: UIView, attribute attributeView: NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attributeView, multiplier: 1.0, constant: 0)
    }
    
    // MARK: Size setting
    func setSize(_ width: CGFloat?, _ height: CGFloat?) {
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
