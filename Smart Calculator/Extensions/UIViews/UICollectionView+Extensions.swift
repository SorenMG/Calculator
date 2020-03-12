//
//  UITableView+Extensions.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 06/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

extension UICollectionView {
    func scrollToBottom(animated: Bool) {
        // Get first index -- we have flipped the collection view
        let firstIndexpath = IndexPath(row: 0, section: 0)
        self.scrollToItem(at: firstIndexpath, at: .top, animated: animated)
    }
}
