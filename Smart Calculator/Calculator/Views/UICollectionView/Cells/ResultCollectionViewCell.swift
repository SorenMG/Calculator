//
//  ResultCollectionViewCell.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 07/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    var item: CalculationStep! {
        didSet {
            label.text = "\(item._operator.rawValue)\(item.value.clean)"
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.textColor = UIColor.resultListTextColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        label.fillSuperview(inset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
