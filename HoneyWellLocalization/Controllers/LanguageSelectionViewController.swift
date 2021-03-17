//
//  LanguageSelectionViewController.swift
//  HoneyWellLocalization
//
//  Created by user on 15/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//


import UIKit

class LanguageSelectionViewController: UITableViewController, ViewControllerDelegate {
       
    // MARK: Variables
    var languagesArray: [DictionaryLanguage]!
    var tableViewDatasource: TableViewDataSource?
    var tableViewDelegate: TableViewDelegate?

    // MARK: Class Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up Views
        languagesArray = HWLocalizationManager.sharedInstance.getLocalLanguageVersions()
        setNavigationBar(isDisable: true)
        
        
        //Register cell on tableview
        self.tableView.registerCell(cell: KHomeListingCell)
        self.tableViewDatasource = TableViewDataSource(withData: languagesArray, cellIdentifier: KHomeListingCell,cellType : .LanguageCell)
        self.tableView.dataSource = self.tableViewDatasource
        self.tableViewDelegate = TableViewDelegate(withDelegate: self)
        
    }
    
    func setNavigationBar(isDisable: Bool)  {
        
        self.title = KSelectLanguage.localize()

        let nextButton = self.navigationItem.backButtonOnRight(title: "Next")
        isDisable ? nextButton.disableButton() : nextButton.enableButton()
        nextButton.addTarget(self, action: #selector(navigationButtonTapped), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem  =  UIBarButtonItem(customView: nextButton)
    }
    
    @objc func navigationButtonTapped(sender : UIButton) {
        let controller = LoginViewController.instantiate(fromAppStoryboard: .LoginSignup)
        self.navigationController?.pushViewController(controller, animated:true)
    }

}

// MARK: Table View Delegates

extension LanguageSelectionViewController
{
    
    func selectedCell(row: Int) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Add a visual cue to indicate that the cell was selected.
        if let cell: HomeListingCell = self.tableView.cellForRow(at: indexPath) as? HomeListingCell
        {
            cell.tickImage.isHidden = false
            
            //Updating language selection locally
            UserDefaults.selectedLanguage = languagesArray[indexPath.row].code
            HWLocalizationManager.sharedInstance.setCurrentBundle(forLanguage: UserDefaults.selectedLanguage)
            setNavigationBar(isDisable: false)
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Remove previous selection, if any.
        if let selectedIndex = self.tableView.indexPathForSelectedRow {
            // Note: Programmatically deslecting does NOT invoke tableView(:didSelectRowAt:), so no risk of infinite loop.
            self.tableView.deselectRow(at: selectedIndex, animated: false)
            // Remove the visual selection indication.
            if let cell: HomeListingCell = self.tableView.cellForRow(at: selectedIndex) as? HomeListingCell
            {
                cell.tickImage.isHidden = true
            }
        }
        return indexPath
    }
}
