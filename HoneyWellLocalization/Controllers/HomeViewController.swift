//
//  HomeViewController.swift
//  HoneyWellLocalization
//
//  Created by user on 15/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//


import UIKit

class HomeViewController: UITableViewController,ViewControllerDelegate {
    
    // MARK: Variables
    let router = Router()
    var tableViewDatasource: TableViewDataSource?
    var tableViewDelegate: TableViewDelegate?

    
    // MARK: Class Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register cell on tableview
        self.tableView.registerCell(cell: KHomeListingCell)
        self.tableViewDatasource = TableViewDataSource(withData: KLabels, cellIdentifier: KHomeListingCell,cellType : .HomeCell)
        self.tableView.dataSource = self.tableViewDatasource
        self.tableViewDelegate = TableViewDelegate(withDelegate: self)
        self.tableView.delegate = self.tableViewDelegate

        //Set up Views
        registerLanguageNotification()
        
    }
    
    func registerLanguageNotification() {
        
        //Active current language bundle
        HWLocalizationManager.sharedInstance.setCurrentBundle(forLanguage: UserDefaults.selectedLanguage)
        
        //Set navigation bar
        //LanguageController.sharedInstance.enableLanguageSelection(isNavigationBarButton: true, forViewController: self)
        
        //Notification registration for language change call
        NotificationCenter.default.removeObserver(self, name: Notification.Name(HWConstants.Notifications.LanguageChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: Notification.Name(HWConstants.Notifications.LanguageChangeNotification), object: nil)
    }
    
    
    // MARK: Notification call when language changed
    
    @objc func updateView() {
        //Notification call when language changed
        self.tableView.reloadData()
    }

}

// MARK: Table View Delegates

extension HomeViewController
{
    //tableview did select call back
    func selectedCell(row: Int) {
        print("Row: \(row)")
    }
}
