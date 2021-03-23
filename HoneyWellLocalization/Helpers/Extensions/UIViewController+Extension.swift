//
//  Extension+UIViewController.swift
//  DenNetwork
//
//  Created by Harish on 11/09/19.
//  Copyright © 2019 Harish. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func PushToScreen(screen:UIViewController){
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(screen, animated: true)
        }
    }
    
    func performSegueToReturnBack()
    {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func showAlert(message:String)
    {
        let alertController = UIAlertController.init(title: "Alert", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "OK", style: .default) { (Continue) in
            self.dismiss(animated: false, completion: nil)
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOptionAlert(title:String,message:String,button1Title:String,button2Title:String,completion:@escaping (_ isSuccess:Bool)->Void)
    {
        
        let alertController = UIAlertController.init(title: title.isEmpty ? nil : title, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction.init(title: button1Title, style: .default) { (Continue) in
            completion(true)
        }
        
        let action2 = UIAlertAction.init(title: button2Title, style: .default) { (Cancel) in
            completion(false)
        }
        
        if button1Title.count > 0
        {
            alertController.addAction(action1)
        }
        if button2Title.count > 0
        {
            alertController.addAction(action2)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
