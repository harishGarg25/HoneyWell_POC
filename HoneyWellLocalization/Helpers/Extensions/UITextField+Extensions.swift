//
//  Extension+UITextField.swift
//  HoneyWellLocalization
//
//  Created by Harish Garg on 17/03/21.
//  Copyright © 2021 AIT. All rights reserved.
//


import UIKit.UITextField

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
