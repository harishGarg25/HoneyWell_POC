//
//  LanguageSelectionViewController.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//


import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - view props
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTitleLabel: UILabel!
    
    // MARK: - internal props
    let router = Router()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailTextField.text = "admin"
//        passwordTextField.text = "admin123"
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        validate()
    }
    
}

//MARK: - textfield delegate methods
extension LoginViewController {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Setup view
extension LoginViewController
{
    func setUpView()  {
        emailTextField.placeholder = KEmailFieldPlaceholder.localize()
        passwordTextField.placeholder = KPasswordFieldPlaceholder.localize()
        //loginTitleLabel.text = KLoginTitle.localize()
        loginButton.setTitle(KLoginButtonTitle.localize(), for: .normal)
    }
}

extension LoginViewController
{
    // MARK: API Call
    
    func hitRequest(params: [String:Any]){
        self.view.showBlurLoader()
        let request = Requests.logInApi(params: params)
        do{
            try router.hitServer(reuest: request) { (result: Result<Login, Error>) in
                DispatchQueue.main.async
                {
                    self.view.removeBluerLoader()
                    switch result{
                    case .success(let model):
                        self.loginSuccess(message: model.message ?? "")
                    case .failure(let error):
                        print("error",error)
                    }
                }
            }
        }catch{
            print("catched error", error.localizedDescription)
        }
    }
    
    func loginSuccess(message: String) {
        self.showOptionAlert(title: "SUCCESS".localize(), message: message, button1Title: "OK".localize(), button2Title: "", completion: { (success) in
            if success
            {
                UserDefaults.standard.setLoginStatus(true)
                let controller = HomeViewController.instantiate(fromAppStoryboard: .Home)
                self.PushToScreen(screen: controller)
            }
        })
    }
    
    func validate() {
        do {
            
            let email = try emailTextField.validatedText(validationType: ValidatorType.username)
            let username = try passwordTextField.validatedText(validationType: ValidatorType.password)
            let data = ["userName": email ,"password": username ,"language": UserDefaults.standard.languageType ?? 1] as [String : Any]
            
            //API call to fetch data from server
            hitRequest(params: data)
            
        } catch(let error) {
            self.showAlert(message: (error as! ValidationError).message)
        }
    }
    
}
