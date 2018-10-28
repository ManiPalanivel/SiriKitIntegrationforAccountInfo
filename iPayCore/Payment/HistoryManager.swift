
//
//  HistoryManager.swift
//  iPay
//
//  Created by Ramesh on 30/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation

public class HistoryManager : NSObject
{
    let historyProvider = HistoryProvider()
    
    public override init ()
    {
        super.init()
    }
    
    public func getPaymentHistory () -> [HistoryEntity]
    {
        return getHistory()
    }
    
    public func savePaymentHistory ( history : HistoryEntity )
    {
        saveHistory( history: history )
    }
    
    func saveHistory( history : HistoryEntity )
    {
        historyProvider.addHistory(history: history)
    }
    
    func getHistory() -> [HistoryEntity]
    {
        return historyProvider.fetchHistorys()!
    }
}
