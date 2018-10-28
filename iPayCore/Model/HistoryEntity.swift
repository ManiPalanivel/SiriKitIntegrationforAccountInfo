//
//  History.swift
//  iPay
//
//  Created by Ramesh on 30/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation

public class HistoryEntity : NSObject
{
    public var displayName : String
    public var accountNumber : String
    public var amount : String
    public var scheduleDate : String
    public var profileIcon : String
    
    public init ( displayName : String?,
                  accountNumber : String?,
                  amount : String?,
                  scheduleDate : String?,
                  profileIcon : String? )
    {
        self.displayName = displayName!
        self.accountNumber = accountNumber!
        self.amount = amount!
        self.scheduleDate = scheduleDate!
        self.profileIcon = profileIcon!
    }
}
