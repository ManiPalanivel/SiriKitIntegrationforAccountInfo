//
//  ProfileViewController.swift
//  iPay
//
//  Created by Ramesh on 01/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation
import iPayCore
import UIKit


class ProfileViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet var profileIcon: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var accountNumberLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    
    var userManager : UserManager = UserManager ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let user = userManager.getUser() as UserEntity;
        
        nameLabel.text = user.displayName
        accountNumberLabel.text = user.accountNumber
        balanceLabel.text = NSString(format: "%.2f", userManager.getAvailableBalance()) as String
        
        let balance : Double = Double(userManager.getAvailableBalance())
        print(balance)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
