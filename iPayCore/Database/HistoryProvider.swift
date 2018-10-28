//
//  HistoryProvider.swift
//  iPay
//
//  Created by Ramesh on 19/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import UIKit
import CoreData

class HistoryProvider: NSObject {

    let databaseManager = DatabaseManager()
    
    public func addHistory(history : HistoryEntity)
    {
        let entity =  NSEntityDescription.entity(forEntityName: "History", in: databaseManager.managedObjectContext)
        let historyEntity = NSManagedObject(entity: entity!, insertInto: databaseManager.managedObjectContext)
        historyEntity.setValue(history.displayName, forKey: "displayName")
        historyEntity.setValue(history.accountNumber, forKey: "accountNumber")
        historyEntity.setValue(history.amount, forKey: "amount")
        historyEntity.setValue(history.scheduleDate, forKey: "scheduleDate")
        historyEntity.setValue(history.profileIcon, forKey: "profileIcon")
        databaseManager.saveContext()
    }
    
    public func fetchHistorys() -> [HistoryEntity]?
    {
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        var historys = [] as [HistoryEntity]
        
        do {
            let historysList = try databaseManager.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            
            for history in historysList
            {
                let historyEntity = HistoryEntity (displayName: "" , accountNumber:"" , amount: "", scheduleDate: "", profileIcon : "")
                historyEntity.displayName = history.value(forKey:"displayName") as! String
                historyEntity.accountNumber = history.value(forKey:"accountNumber") as! String
                historyEntity.amount = history.value(forKey:"amount") as! String
                historyEntity.scheduleDate = history.value(forKey:"scheduleDate") as! String
                historyEntity.profileIcon = history.value(forKey:"profileIcon") as! String
                historys.append(historyEntity)
            }
        }
        catch
        {
            print("Error with request: \(error)")
        }
        return historys
    }
    
    public func getHistoryCount () -> Int
    {
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        do {
            let historysList = try databaseManager.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            return historysList.count
            }
        catch
        {
            print("Error with request: \(error)")
        }
        return 0
    }
}
