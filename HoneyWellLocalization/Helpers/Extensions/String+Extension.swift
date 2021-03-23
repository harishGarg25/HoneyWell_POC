//
//  Extension+String.swift
//  DenNetwork
//
//  Created by Harish on 11/09/19.
//  Copyright © 2019 Harish. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func localize() -> String {
       return NSLocalizedString(self, tableName: "", bundle: HWLocalizationManager.sharedInstance.currentBundle, value: "", comment: "")
    }
}

class LocalisableLabel: UILabel {

    @IBInspectable var localisedKey: String? {
        didSet {
            guard let key = localisedKey else { return }
            text = key.localize()
        }
    }

}
