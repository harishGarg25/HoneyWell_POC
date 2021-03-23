//
//  NavigationController.swift
//  HoneyWellLocalization
//
//  Created by user on 18/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    var controller : UIViewController?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Hide navigation bar from rootviewcontroller
        self.interactivePopGestureRecognizer?.delegate = self
        
        //addViewController()
    }
    
    @objc func addViewController()
    {
        
        //UserDefaults.standard.setLoginStatus(false)
        
        if let isLoggedIn :Bool = UserDefaults.standard.isLoggedIn
        {
            if isLoggedIn
            {
                controller = HomeViewController.instantiate(fromAppStoryboard: .Home)
                self.viewControllers = [controller!]
            }
            else
            {
                controller = LoginViewController.instantiate(fromAppStoryboard: .LoginSignup)
                self.viewControllers = [controller!]
            }
        }
        else
        {
            controller = LoginViewController.instantiate(fromAppStoryboard: .LoginSignup)
            self.viewControllers = [controller!]
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
