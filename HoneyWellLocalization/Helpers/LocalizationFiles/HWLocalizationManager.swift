//
//  BKLocalizationManager.swift
//  HoneyWellLocalization
//
//  Created by user on 15/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//


import Foundation
import UIKit

@objcMembers class HWLocalizationManager : NSObject {
    
    private static var privateSharedInstance: HWLocalizationManager?
    static var sharedInstance: HWLocalizationManager {
        if privateSharedInstance == nil {
            privateSharedInstance = HWLocalizationManager()
        }
        return privateSharedInstance!
    }
    var currentBundle = Bundle.main
    let manager = FileManager.default
    lazy var bundlePath: URL = {
        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)
        let bundlePath = documents.appendingPathComponent(HWLocalizable.HWBundleName, isDirectory: true)
        return bundlePath
    }()

    func setCurrentBundle(forLanguage:String){
        do {
            currentBundle = try returnCurrentBundleForLanguage(lang: forLanguage)
        }catch {
            currentBundle = Bundle(path: getPathForLocalLanguage(language: "en"))!
        }
    }
    
    public func returnCurrentBundleForLanguage(lang:String) throws -> Bundle {
        if manager.fileExists(atPath: bundlePath.path) == false {
            return Bundle(path: getPathForLocalLanguage(language: lang))!
        }
        do {
            let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
            _ = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let enumerator = FileManager.default.enumerator(at: bundlePath ,includingPropertiesForKeys: resourceKeys,options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
                return true
            })!
            for case let folderURL as URL in enumerator {
                _ = try folderURL.resourceValues(forKeys: Set(resourceKeys))
                if folderURL.lastPathComponent == ("\(lang).lproj"){
                    let enumerator2 = FileManager.default.enumerator(at: folderURL,includingPropertiesForKeys: resourceKeys,options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
                        return true
                    })!
                    for case let fileURL as URL in enumerator2 {
                        _ = try fileURL.resourceValues(forKeys: Set(resourceKeys))
                        if fileURL.lastPathComponent == "Localizable.strings" {
                            return Bundle(url: folderURL)!
                        }
                    }
                }
            }
        } catch {
            return Bundle(path: getPathForLocalLanguage(language: lang))!
        }
        return Bundle(path: getPathForLocalLanguage(language: lang))!
    }
    
    func getLocalLanguageVersions() -> [DictionaryLanguage] {
        return [DictionaryLanguage(code: "en", fullName: "English"),DictionaryLanguage(code: "de", fullName: "German")]
    }
    private func getPathForLocalLanguage(language: String) -> String {
        return Bundle.main.path(forResource: language, ofType: "lproj")!
    }
}

