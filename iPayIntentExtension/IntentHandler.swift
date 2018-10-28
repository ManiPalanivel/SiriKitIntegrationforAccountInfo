//
//  IntentHandler.swift
//  iPayIntentExtension
//
//  Created by Ramesh on 24/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

class IntentHandler: INExtension
{
    override func handler(for intent: INIntent) -> Any?
    {
        
        if intent is INSendPaymentIntent
        {
           return SendPaymentIntentHandler ()
        }
        if #available(iOSApplicationExtension 11.0, *) {
            if intent is INSearchForAccountsIntent
            {
                return SearchAccountIntentHandler()
            }
        } else {
            // Fallback on earlier versions
            return nil
        }
        return nil
    }
}
