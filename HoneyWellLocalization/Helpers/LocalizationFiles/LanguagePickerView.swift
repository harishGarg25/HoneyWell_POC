//
//  LanguagePickerView.swift
//  HoneyWellLocalization
//
//  Created by user on 15/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//


import Foundation
import UIKit

protocol LanguagePickerViewDelegate: class {
    func didTapDone(lang:DictionaryLanguage)
    func didTapCancel()
}

class LanguagePickerView: UIPickerView,UIPickerViewDataSource,UIPickerViewDelegate {
    
    public private(set) var toolbar: UIToolbar?
    public weak var languagePickerDelegate: LanguagePickerViewDelegate?
    var doneButton: UIBarButtonItem = UIBarButtonItem()
    var cancelButton: UIBarButtonItem = UIBarButtonItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        doneButton = UIBarButtonItem(title: KDoneString.localize(), style: .plain, target: self, action: #selector(doneTapped))
        doneButton.tag = 100
        doneButton.tintColor = UIColor(displayP3Red: 45/255, green: 118/255, blue: 216/255, alpha: 1.0)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        cancelButton = UIBarButtonItem(title:  KCancelString.localize(), style: .plain, target: self, action: #selector(cancelTapped))
        cancelButton.tag = 101
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.delegate = self
        self.dataSource = self
        self.setValue(UIColor.white, forKey: "backgroundColor")
        self.backgroundColor = UIColor.white
        self.toolbar = toolBar
    }
    
    func updateViewForLocalisation()  {
        self.doneButton.title = KDoneString.localize()
        self.cancelButton.title = KCancelString.localize()
    }
    
    @objc func doneTapped() {
        self.languagePickerDelegate?.didTapDone(lang: HWLanguageServiceManager.sharedInstance.languagesArray[self.selectedRow(inComponent: 0)])
    }
    
    @objc func cancelTapped() {
        self.languagePickerDelegate?.didTapCancel()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HWLanguageServiceManager.sharedInstance.languagesArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let lang = HWLanguageServiceManager.sharedInstance.languagesArray[row]
        let languageDescriptionStr = ("\(lang.code.uppercased()) - \(lang.fullName)")
        return languageDescriptionStr
    }
    
}
