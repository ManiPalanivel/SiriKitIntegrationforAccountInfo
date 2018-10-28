//
//  FundTransferController.swift
//  iPay
//
//  Created by Ramesh on 01/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation
import UIKit
import iPayCore

class FundTransferController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet var payeeAccountNumberLabel: UITextField!
    @IBOutlet var payeeNameLabel: UITextField!
    
    let personManager : PersonManager = PersonManager ()
    let accountManager : AccountManager = AccountManager()
    let userManager : UserManager = UserManager()
    
    
    
    @IBOutlet var amountLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField .resignFirstResponder()
        return true
    }
    
    @IBAction func payButtonAction(_ sender: Any)
    {
        if (payeeNameLabel.text?.isEmpty)!
        {
            let alertViewController = UIAlertController(title: "Error", message: "Please enter your Payee name.", preferredStyle: UIAlertController.Style.alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
            self.present(alertViewController, animated: true, completion:nil)
            return;
        }
        
        if (payeeAccountNumberLabel.text?.isEmpty)!
        {
            let alertViewController = UIAlertController(title: "Error", message: "Please enter Account Number.", preferredStyle: UIAlertController.Style.alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertViewController, animated: true, completion:nil)
            return
        }
        
        if (amountLabel.text?.isEmpty)!
        {
            let alertViewController = UIAlertController(title: "Error", message: "Please enter Amount.", preferredStyle: UIAlertController.Style.alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertViewController, animated: true, completion:nil)
            return
        }
        
        let persons : [PersonEntity] = personManager.getPersons()
        
        let results = persons.filter { $0.displayName == payeeNameLabel.text }
        
        if results.isEmpty {
            let alertViewController = UIAlertController(title: "Message", message: "Payee not available.", preferredStyle: UIAlertController.Style.alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertViewController, animated: true, completion:nil)
            return
        }
        
        for person in persons
        {
            if person.displayName == payeeNameLabel.text
            {
                if person.accountNumber ==  payeeAccountNumberLabel.text
                {
                    let amount = NSString(string: amountLabel.text!) as NSString
                    
                    if  userManager.getAvailableBalance() < amount.floatValue as Float
                    {
                        let alertViewController = UIAlertController(title: "Message", message: "Insufficient balance.", preferredStyle: UIAlertController.Style.alert)
                        alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
                        self.present(alertViewController, animated: true, completion:nil)
                        return
                    }
                    
                    if self.accountManager.sendMoney ( amount : amountLabel.text!, payee : person)
                    {
                        let alertViewController = UIAlertController(title: "Message", message: "Successfully transfered.", preferredStyle: UIAlertController.Style.alert)
                        alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
                        self.present(alertViewController, animated: true, completion:nil)
                    }
                    else
                    {
                        let alertViewController = UIAlertController(title: "Error", message: "Transaction Failed.", preferredStyle: UIAlertController.Style.alert)
                        alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
                        self.present(alertViewController, animated: true, completion:nil)
                    }
                }
                else
                {
                    let alertViewController = UIAlertController(title: "Error", message: "Payee name and account number not match.", preferredStyle: UIAlertController.Style.alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
                    self.present(alertViewController, animated: true, completion:nil)
                }
            }
        }
    }
}
