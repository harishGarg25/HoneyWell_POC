//
//  Extension.swift
//  HoneyWellLocalization
//
//  Created by user on 15/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation

//MARK: Userdefaults
extension UserDefaults {
    
    var languageType: String? {
        return string(forKey: "languageType")
    }
    
    func setLanguageType(_ authorization: String) {
        set(authorization, forKey: "languageType")
    }
    
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        removePersistentDomain(forName: domain)
        synchronize()
    }
}
