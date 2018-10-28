//
//  AccountManager.swift
//  iPay
//
//  Created by Ramesh on 25/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation

public class AccountManager : NSObject
{
    let  userManager = UserManager()
    let  historyManager = HistoryManager()
    
    public override init ()
    {
        super.init()
    }
    
    public func checkAvailableBalence () -> Float
    {
        return userManager.getBalance()
    }
    
    public func sendMoney ( amount : String, payee : PersonEntity ) -> Bool
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date as Date)
        
        let history = HistoryEntity (displayName: payee.displayName , accountNumber:payee.accountNumber , amount: amount, scheduleDate: dateString, profileIcon : payee.profileIcon)
        self.historyManager.savePaymentHistory(history: history)
        
        var balance = self.userManager.getBalance()
        balance = balance - Float(amount)!
        self.userManager.updateBalaence(balance: balance)
        return true;
    }
}
