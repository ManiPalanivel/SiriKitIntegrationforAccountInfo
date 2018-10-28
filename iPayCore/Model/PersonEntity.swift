//
//  Person.swift
//  iPay
//
//  Created by Ramesh on 24/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation

public class PersonEntity : NSObject
{
    public var displayName : String
    public var accountNumber : String
    public var firstName : String
    public var lastName : String
    public var dateOfBirth : String
    public var age : String
    public var profileIcon : String
    
    public init ( displayName : String?,
                  accountNumber : String?,
                  firstName : String?,
                  lastName : String?,
                  dateOfBirth : String?,
                  age : String?,
                  profileIcon : String? )
    {
        self.displayName = displayName!
        self.accountNumber = accountNumber!
        self.firstName = firstName!
        self.lastName = lastName!
        self.dateOfBirth = dateOfBirth!
        self.age = age!
        self.profileIcon = profileIcon!
    }
}

