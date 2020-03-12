//
//  ResultCollectionView.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 07/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

class ResultCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
