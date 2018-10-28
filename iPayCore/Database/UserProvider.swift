//
//  UserProvider.swift
//  iPay
//
//  Created by Ramesh on 19/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import UIKit
import CoreData

class UserProvider: NSObject
{
    let databaseManager = DatabaseManager()
    
    public func addUSer(user : UserEntity)
    {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let usersList = try databaseManager.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            if usersList.count>0 {
               return
            }
            let entity =  NSEntityDescription.entity(forEntityName: "User", in: databaseManager.managedObjectContext)
            let userEntity = NSManagedObject(entity: entity!, insertInto: databaseManager.managedObjectContext)
            userEntity.setValue(user.displayName, forKey: "displayName")
            userEntity.setValue(user.accountNumber, forKey: "accountNumber")
            userEntity.setValue(user.firstName, forKey: "firstName")
            userEntity.setValue(user.lastName, forKey: "lastName")
            userEntity.setValue(user.dateOfBirth, forKey: "dateOfBirth")
            userEntity.setValue(user.age, forKey: "age")
            userEntity.setValue(user.balence, forKey: "balance")
            userEntity.setValue(user.email_ID, forKey: "email_ID")
            userEntity.setValue(user.userName, forKey: "userName")
            userEntity.setValue(user.password, forKey: "password")
            databaseManager.saveContext()
        }
        catch
        {
            print("Error with request: \(error)")
        }
    }
    
    public func fetchUser() -> UserEntity?
    {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let userEntity = UserEntity(displayName: "", accountNumber: "", firstName: "", lastName: "", dateOfBirth: "", age: "", balence: "", email_ID: "", userName: "", password: "") as UserEntity
        
        do {
            let usersList = try databaseManager.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            
            let user = usersList[0] as? User
            
            userEntity.displayName = user?.value(forKey:"displayName") as! String
            userEntity.accountNumber = user?.value(forKey:"accountNumber") as! String
            userEntity.firstName = user?.value(forKey:"firstName") as! String
            userEntity.lastName = user?.value(forKey:"lastName") as! String
            userEntity.dateOfBirth = user?.value(forKey:"dateOfBirth") as! String
            userEntity.age = user?.value(forKey:"age") as! String
            userEntity.balence = user?.value(forKey:"balance") as! String
            userEntity.email_ID = user?.value(forKey:"email_ID") as! String
            userEntity.userName = user?.value(forKey:"userName") as! String
            userEntity.password = user?.value(forKey:"password") as! String
            
            }
            catch
            {
                print("Error with request: \(error)")
            }
        return userEntity
    }
    
    public func updateBalance(balance : String)
    {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let usersList = try databaseManager.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            let user = usersList[0] as? User
            user?.setValue(balance, forKey:"balance")
            databaseManager.saveContext()
        }
        catch
        {
            print("Error with request: \(error)")
        }

    }
}
