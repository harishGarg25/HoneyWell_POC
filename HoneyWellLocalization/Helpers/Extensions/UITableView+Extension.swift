//
//  Extension+UITableView.swift
//  DenNetwork
//
//  Created by Harish on 11/09/19.
//  Copyright © 2019 Harish. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell(cell: String) {
        let cellNib = UINib(nibName: cell, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: cell)
    }
}

