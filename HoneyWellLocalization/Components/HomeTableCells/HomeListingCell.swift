//
//  HomeListingCell.swift
//  HoneyWellLocalization
//
//  Created by user on 15/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import UIKit

class HomeListingCell: UITableViewCell {
    
//    var currency:Currency?{
//        didSet{
//            self.nameLabel.text = currency.
//        }
//    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
