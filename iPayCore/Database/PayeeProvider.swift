//
//  PayeeProvider.swift
//  iPay
//
//  Created by Ramesh on 19/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import UIKit
import CoreData

class PayeeProvider: NSObject {

    let databaseManager = DatabaseManager()
    
    public func addPayee(payee : PersonEntity)
    {
        let entity =  NSEntityDescription.entity(forEntityName: "Payee", in: databaseManager.managedObjectContext)
        let payeeEntity = NSManagedObject(entity: entity!, insertInto: databaseManager.managedObjectContext)
        payeeEntity.setValue(payee.displayName, forKey: "displayName")
        payeeEntity.setValue(payee.accountNumber, forKey: "accountNumber")
        payeeEntity.setValue(payee.firstName, forKey: "firstName")
        payeeEntity.setValue(payee.lastName, forKey: "lastName")
        payeeEntity.setValue(payee.dateOfBirth, forKey: "dateOfBirth")
        payeeEntity.setValue(payee.age, forKey: "age")
        payeeEntity.setValue(payee.profileIcon, forKey: "profileIcon")
        databaseManager.saveContext()
    }
    
    public func fetchPayees() -> [PersonEntity]?
    {
        let fetchRequest: NSFetchRequest<Payee> = Payee.fetchRequest()
        
        var payees = [] as [PersonEntity]
        
        do {
            let payeeList = try databaseManager.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            
            for payee in payeeList {
                
                let payeeEntity = PersonEntity (displayName: "", accountNumber: "", firstName: "", lastName: "", dateOfBirth: "", age: "",profileIcon : "")
                payeeEntity.displayName = payee.value(forKey:"displayName") as! String
                payeeEntity.accountNumber = payee.value(forKey:"accountNumber") as! String
                payeeEntity.firstName = payee.value(forKey:"firstName") as! String
                payeeEntity.lastName = payee.value(forKey:"lastName") as! String
                payeeEntity.dateOfBirth = payee.value(forKey:"dateOfBirth") as! String
                payeeEntity.age = payee.value(forKey:"age") as! String
                payeeEntity.profileIcon = payee.value(forKey:"profileIcon") as! String
                payees.append(payeeEntity)
            }
        }
        catch
        {
            print("Error with request: \(error)")
        }
        return payees
    }
    
    public func getPayeesCount() -> Int
    {
        let fetchRequest: NSFetchRequest<Payee> = Payee.fetchRequest()
        
        do {
            let payeeList = try databaseManager.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            return payeeList.count
            }
        catch
        {
            print("Error with request: \(error)")
        }
        return 0
    }
}
