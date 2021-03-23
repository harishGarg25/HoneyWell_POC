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
    var customers = [UserData]()
    
    
    // MARK: Class Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = KCustomers.localize()
        
        //Register cell on tableview
        self.tableView.registerCell(cell: KHomeListingCell)
        self.tableViewDelegate = TableViewDelegate(withDelegate: self)
        self.tableView.delegate = self.tableViewDelegate
        
        //Set up Views
        navigationItem.hidesBackButton = true
        registerLanguageNotification()
        
        //API call to fetch data from server
        hitRequest(params: ["language": "\(UserDefaults.standard.languageType ?? 1)"])
        
    }
    
    func registerLanguageNotification() {
        
        //Active current language bundle
        HWLocalizationManager.sharedInstance.setCurrentBundle(forLanguage: UserDefaults.selectedLanguage)
        
        //Set navigation bar
        LanguageController.sharedInstance.enableLanguageSelection(isNavigationBarButton: true, forViewController: self)
        
        //Notification registration for language change call
        NotificationCenter.default.removeObserver(self, name: Notification.Name(HWConstants.Notifications.LanguageChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: Notification.Name(HWConstants.Notifications.LanguageChangeNotification), object: nil)
    }
    
    
    // MARK: Notification call when language changed
    
    @objc func updateView() {
        self.title = KCustomers.localize()
        //API call to fetch data from server
        hitRequest(params: ["language": "\(UserDefaults.standard.languageType ?? 1)"])
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

extension HomeViewController
{
    // MARK: API Call
    
    func hitRequest(params: [String:String]){
        self.view.showBlurLoader()
        let request = Requests.employeeList(params: params)
        do{
            try router.hitServer(reuest: request) { (result: Result<UsersListBase, Error>) in
                DispatchQueue.main.async
                {
                    self.view.removeBluerLoader()
                    switch result{
                    case .success(let model):
                        if model.responseCode == 200
                        {
                            self.customers = model.data ?? []
                            self.tableViewDatasource = TableViewDataSource(withData: self.customers, cellIdentifier: KHomeListingCell,cellType : .HomeCell)
                            self.tableView.dataSource = self.tableViewDatasource
                        }else
                        {
                            self.showAlert(message: model.message ?? "")
                        }
                        self.tableView.reloadData()
                    case .failure(let error):
                        print("error",error)
                        self.showAlert(message: error.localizedDescription)
                    }
                }
            }
        }catch{
            print("catched error", error.localizedDescription)
        }
    }
}

