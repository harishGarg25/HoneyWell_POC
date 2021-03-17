//
//  TableViewController.swift
//  HoneyWellLocalization
//
//  Created by Harish Garg on 17/03/21.
//  Copyright © 2021 AIT. All rights reserved.
//

import Foundation
import UIKit


protocol ViewControllerDelegate: class {
    func selectedCell(row: Int)
}

class TableViewDelegate: NSObject, UITableViewDelegate {
    weak var delegate: ViewControllerDelegate?
    
    init(withDelegate delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(row: indexPath.row)
    }
}

class TableViewDataSource: NSObject, UITableViewDataSource {
    var data = [Any]()
    var itemIdentifier:String?
    var cellType : CELL_TYPE = .LanguageCell

    init(withData data: [Any], cellIdentifier: String,cellType : CELL_TYPE) {
        self.data = data
        self.itemIdentifier = cellIdentifier
        self.cellType = cellType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.itemIdentifier!)
        {
            cell.tag = indexPath.row
            configureCell(cell: cell)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func configureCell(cell : UITableViewCell) {
        switch cellType {
        case .LanguageCell :
            if let actualCell = cell as? HomeListingCell {
                if let object = self.data[cell.tag] as? DictionaryLanguage
                {
                    actualCell.nameLabel.text = NSLocalizedString(object.fullName, tableName: "", bundle: HWLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
                }
            }
        case .HomeCell:
            if let actualCell = cell as? HomeListingCell {
                actualCell.nameLabel.text = NSLocalizedString(self.data[cell.tag] as! String, tableName: "", bundle: HWLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
            }
        }
    }
    
}
