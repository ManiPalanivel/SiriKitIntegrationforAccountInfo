//
//  MenuViewController.swift
//  iPay
//
//  Created by Ramesh on 01/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation
import UIKit
import iPayCore

class MenuViewController: UITableViewController {
    
    let userManager : UserManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 5
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
        
        if indexPath.row == 0
        {
            cell.titleLabel.text = "Profile"
            cell.iconImageView.image = UIImage(named: "icon-profile.png")
        }
        else if indexPath.row == 1
        {
            cell.titleLabel.text = "Fund Transfer"
            cell.iconImageView.image = UIImage(named: "icon-transfer.png")
        }
        else if indexPath.row == 2
        {
            cell.titleLabel.text = "Transaction History"
            cell.iconImageView.image = UIImage(named: "icon-tranHistory.png")
        }
        else if indexPath.row == 3
        {
            cell.titleLabel.text = "Payees"
            cell.iconImageView.image = UIImage(named: "icon-payees.png")
        }
        else
        {
            cell.titleLabel.text = "Logout"
            cell.iconImageView.image = UIImage(named: "icon-logout.png")
        }
        
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
           self.performSegue(withIdentifier: "Profile", sender: self)
        }
        else if indexPath.row == 1
        {
            self.performSegue(withIdentifier: "FundTransfer", sender: self)
        }
        else if indexPath.row == 2
        {
            self.performSegue(withIdentifier: "HistoryList", sender: self)
        }
        else if indexPath.row == 3
        {
            self.performSegue(withIdentifier: "PayeeList", sender: self)
        }
        else
        {
            userManager.updateAppLoginInfo(islogin: false)
        }
    }
    
}
