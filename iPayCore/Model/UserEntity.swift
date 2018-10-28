
//
//  User.swift
//  iPay
//
//  Created by Ramesh on 25/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation

public class UserEntity : NSObject
{
    public var displayName : String
    public var accountNumber : String
    public var firstName : String
    public var lastName : String
    public var dateOfBirth : String
    public var age : String
    public var balence : String
    public var email_ID : String
    public var userName : String
    public var password : String
    
    public init ( displayName : String?,
                  accountNumber : String?,
                  firstName : String?,
                  lastName : String?,
                  dateOfBirth : String?,
                  age : String?,
                  balence : String?,
                  email_ID : String?,
                  userName : String?,
                  password : String? )
    {
        self.displayName = displayName!
        self.accountNumber = accountNumber!
        self.firstName = firstName!
        self.lastName = lastName!
        self.dateOfBirth = dateOfBirth!
        self.age = age!
        self.balence = balence!
        self.email_ID = email_ID!
        self.userName = userName!
        self.password = password!
    }
}
