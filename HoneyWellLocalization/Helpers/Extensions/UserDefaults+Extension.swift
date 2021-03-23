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
    
    func setLoginStatus(_ bool: Bool) {
        set(bool, forKey: "login")
    }
    
    var isLoggedIn: Bool {
        return bool(forKey: "login")
    }
    
    var languageType: Int? {
        if let language = UserDefaults.selectedLanguage as? String
        {
            return language == "en" ? 1 : 2
        }
        return 1
    }
    
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        removePersistentDomain(forName: domain)
        synchronize()
    }
}
