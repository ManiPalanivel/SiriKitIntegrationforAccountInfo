//
//  UserManager.swift
//  iPay
//
//  Created by Ramesh on 25/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation

public class UserManager : NSObject
{
    let userProvider = UserProvider()
    public override init ()
    {
        super.init()
    }
    
    public func checkUserAvailableorNot ( userName : String ) -> Bool
    {
        let user = getUser()
        
        if user.userName == userName
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    public func authendicateUser ( userName : String, password : String ) -> Bool
    {
        let user = getUser()
        
        if user.userName == userName &&  user.password == password
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    public func checkAppAuthendicateOrNot ( ) -> Bool
    {
        let isLogin = getAppLoginInfo()
        
        if isLogin
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    public func getAvailableBalance () -> Float
    {
        let balance = getBalance() as Float
        return balance
    }
    
    public func addUser ( user : UserEntity )
    {
        userProvider.addUSer(user: user)
    }
    
    public func getUser() -> UserEntity
    {
        return userProvider.fetchUser()!
    }
    
    public func updateAppLoginInfo ( islogin : Bool )
    {
        let userDefaults = UserDefaults.standard
        userDefaults.bool(forKey:"login" )
        userDefaults.synchronize()
    }
    
    func getAppLoginInfo() -> Bool
    {
        let userDefaults = UserDefaults.standard
        let isLogin  = userDefaults.bool(forKey: "login") as Bool
        return isLogin
    }
    
    public func updateBalaence ( balance : Float )
    {
        let balanceString = NSString(format: "%.2f", balance) as String
        userProvider.updateBalance(balance: balanceString)
    }
    
    func getBalance() -> Float
    {
        let user = userProvider.fetchUser()
        return Float((user?.balence)!)!
    }
    
}
