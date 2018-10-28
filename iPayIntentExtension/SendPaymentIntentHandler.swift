//
//  SendPaymentIntentHandler.swift
//  iPay
//
//  Created by Ramesh on 24/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Intents
import iPayCore
import LocalAuthentication

class SendPaymentIntentHandler: NSObject, INSendPaymentIntentHandling
{
    
    // MARK: - init
    public override init ()
    {
        super.init()
    }
    
    // MARK: - Private variables
    public let personManager : PersonManager = PersonManager ()
    public let accountManager : AccountManager = AccountManager ()
    public let userManager : UserManager = UserManager ()
    public var resolutionResult : INPersonResolutionResult?
    
    // MARK: - Handule Payment
    func handle(intent: INSendPaymentIntent, completion: @escaping (INSendPaymentIntentResponse) -> Swift.Void)
    {
        var responseCode: INSendPaymentIntentResponseCode = .failure
        var matchedPersons : [PersonEntity] = self.personManager.matchedPersons(displayName: (intent.payee?.displayName)!)
        
        authenticate(successAuth:
        {
            let balance = Float((intent.currencyAmount?.amount!)!)
            let balanceString = NSString(format: "%.2f", balance) as String
            _ = self.accountManager.sendMoney ( amount :balanceString, payee : matchedPersons[0])
            responseCode = .success
            let userActivity = NSUserActivity(activityType: String(describing: INSendPaymentIntent()))
            userActivity.userInfo = ["currencyAmount": Int((intent.currencyAmount?.amount!)!)]
            userActivity.requiredUserInfoKeys = Set(["currencyAmount"])
            let resolutionResult = INSendPaymentIntentResponse(code: responseCode, userActivity: userActivity)
            completion(resolutionResult)
        },
        failure: {_ in
            
            responseCode = .failure
            let userActivity = NSUserActivity(activityType: String(describing: INSendPaymentIntent()))
            userActivity.userInfo = ["currencyAmount": Int((intent.currencyAmount?.amount!)!)]
            userActivity.requiredUserInfoKeys = Set(["currencyAmount"])
            let resolutionResult = INSendPaymentIntentResponse(code: responseCode, userActivity: userActivity)
            completion(resolutionResult)
        })
    }
    
    // MARK: - Confirm Payment
    func confirm(intent: INSendPaymentIntent, completion: @escaping (INSendPaymentIntentResponse) -> Swift.Void)
    {
        completion(INSendPaymentIntentResponse(code: .success, userActivity: nil))
    }
    
    // MARK: - Resolve Payment
    func resolvePayee(for intent: INSendPaymentIntent, with completion: @escaping (INPersonResolutionResult) -> Swift.Void)
    {
        if intent.payee == nil
        {
            completion(INPersonResolutionResult.needsValue())
        }
        
//        if !userManager.checkAppAuthendicateOrNot() {
//            completion(INPersonResolutionResult.unsupported())
//        }
        
        var matchedPersons : [PersonEntity] = self.personManager.matchedPersons(displayName: (intent.payee?.displayName)!)
        print(matchedPersons)
        
        switch matchedPersons.count
        {
            case 2 ... Int.max:
                var persons : [INPerson] = [];
                
                for person in matchedPersons
                {
                    persons.append(self.personManager.isPerson(person: person))
                }
                self.resolutionResult = INPersonResolutionResult.disambiguation(with: persons)
            case 1:
                self.resolutionResult = INPersonResolutionResult.success(with: self.personManager.isPerson(person: matchedPersons[0]))
            default:
                break
        }
        
        completion(self.resolutionResult!)
    }
    
    func resolveCurrencyAmount(for intent: INSendPaymentIntent, with completion: @escaping (INCurrencyAmountResolutionResult) -> Swift.Void)
    {
        let resolutionResult: INCurrencyAmountResolutionResult
        
        if let amount = intent.currencyAmount
        {
            let balance : Double = Double(userManager.getAvailableBalance())
            
            if (amount.amount?.doubleValue)! <= balance
            {
                resolutionResult = INCurrencyAmountResolutionResult.success(with: amount)
            }
            else
            {
                let decimalAmount = NSDecimalNumber(value:userManager.getAvailableBalance())
                let cuurenceAmount = INCurrencyAmount(amount: decimalAmount, currencyCode: "USD")
                resolutionResult = INCurrencyAmountResolutionResult.disambiguation(with: [cuurenceAmount])
            }
        }
        else
        {
            resolutionResult = INCurrencyAmountResolutionResult.needsValue()
        }
        completion(resolutionResult)
    }
    
//    public func resolveNote(forSendPayment intent: INSendPaymentIntent, with completion: @escaping (INStringResolutionResult) -> Swift.Void)
//    {
//            let resolutionResult: INStringResolutionResult
//            resolutionResult = INStringResolutionResult.success(with: intent.note!)
//            completion(resolutionResult)
//    }
    
    func authenticate(successAuth: @escaping () -> Void, failure: @escaping (NSError?) -> Void)
    {
        let authenticationContext = LAContext()
        var error:NSError?
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            failure(error)
            return
        }
        
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Unlock to send the money",
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    successAuth()
                    
                }else {
                    let message = self.errorMessageForLAErrorCode(errorCode: (error! as NSError).code)
                    print(message)
                    failure(error! as NSError)
                }
        })
    }
    
    func errorMessageForLAErrorCode( errorCode:Int ) -> String
    {
        var message = ""
        
        switch errorCode
        {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
        }
        return message
    }
}
