//
//  ViewController.swift
//  iPay
//
//  Created by Ramesh on 24/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import UIKit
import Intents
import iPayCore

class ViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextFiled: UITextField!
    
    let userManager : UserManager = UserManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        INPreferences.requestSiriAuthorization { status in
            switch status
            {
            case .authorized:
                print("Siri: Authorized")
            default:
                print("Siri: Not authorized")
            }
            let user = self.userManager.getUser()
            print(user.displayName)
        }
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonAction(_ sender: Any)
    {
        if (usernameTextField.text?.isEmpty)!
        {
            let alertViewController = UIAlertController(title: "Error", message: "Please enter your user name.", preferredStyle: UIAlertController.Style.alert)
             alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
            self.present(alertViewController, animated: true, completion:nil)
        }
        
        if (passwordTextFiled.text?.isEmpty)!
        {
            let alertViewController = UIAlertController(title: "Error", message: "Please enter your password.", preferredStyle: UIAlertController.Style.alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
            self.present(alertViewController, animated: true, completion:nil)
        }
        
        if userManager.authendicateUser(userName: usernameTextField.text! , password: passwordTextFiled.text!){
            userManager.updateAppLoginInfo(islogin: true)
            self.performSegue(withIdentifier: "HomeView", sender: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField .resignFirstResponder()
        return true
    }
}

