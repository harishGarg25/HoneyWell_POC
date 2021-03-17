//
//  Extension.swift
//  HoneyWellLocalization
//
//  Created by user on 15/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//
import UIKit
import Foundation

//MARK: UINavigationItem
extension UINavigationItem {
    
    func backButtonOnRight(title : String) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(NSLocalizedString("Next", tableName: "", bundle: HWLocalizationManager.sharedInstance.currentBundle, value: "", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }
}

//MARK: UIButton
extension UIButton
{
    func disableButton()  {
        self.alpha = 0.6
        self.isUserInteractionEnabled = false
    }
    
    func enableButton()  {
        self.alpha = 1.0
        self.isUserInteractionEnabled = true
    }
    
    func setAccessibilityLabel(label : String)  {
        self.accessibilityLabel = label
    }
}
