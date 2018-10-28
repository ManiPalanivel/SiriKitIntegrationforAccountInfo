//
//  SearchAccountsIntentHandler.swift
//  iPayIntentExtension
//
//  Created by Aspire on 24/10/18.
//  Copyright © 2018 Aspire Syatems. All rights reserved.
//


import Intents
import iPayCore
import LocalAuthentication

@available(iOSApplicationExtension 11.0, *)
class SearchAccountIntentHandler: NSObject, INSearchForAccountsIntentHandling {
    
    // MARK: - init
    public override init ()
    {
        super.init()
    }
    
    public let accountManager : AccountManager = AccountManager ()
    
    func handle(intent: INSearchForAccountsIntent,
                completion: @escaping (INSearchForAccountsIntentResponse) -> Void){
        authenticate(successAuth:
            {
                let balance : Float = 10000.00
                let resolutionResult = INSearchForAccountsIntentResponse(code: .success, userActivity: nil )
                let account = INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Manoj"), number: "123456", accountType: .saving, organizationName: INSpeakableString(spokenPhrase: "Aspire"), balance: INBalanceAmount(amount: NSDecimalNumber(value: balance), currencyCode: "INR"), secondaryBalance: nil)
                let account2 = INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Test"), number: "1234567", accountType: .saving, organizationName: INSpeakableString(identifier: "Test", spokenPhrase: "Test Organisation", pronunciationHint: "Aspire"), balance: INBalanceAmount(amount: NSDecimalNumber(value: balance - 2000), currencyCode: "INR"), secondaryBalance: nil)
                var array: [INPaymentAccount] = []
                array.append(account)
                array.append(account2)
                for arrayItem in array {
                    if(arrayItem.nickname == intent.accountNickname)
                    {
                        if resolutionResult.accounts == nil{
                            resolutionResult.accounts = [arrayItem]
                        }
                        else {
                            resolutionResult.accounts?.append(arrayItem)
                        }
                    }
                }
                if resolutionResult.accounts == nil {
                    resolutionResult.accounts = [account]
                }
                completion(resolutionResult)
            },
         failure: {_ in
            let userActivity = NSUserActivity(activityType: String(describing: INSearchForAccountsIntent()))
            let resolutionResult = INSearchForAccountsIntentResponse(code: .failure, userActivity: userActivity )
             completion(resolutionResult)
        })
    }
    
    func confirm(intent: INSearchForAccountsIntent, completion: (INSearchForAccountsIntentResponse) -> Void){
        completion(INSearchForAccountsIntentResponse(code: .success, userActivity: nil))
    }
    
    func resolveOrganizationName(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        if intent.organizationName?.spokenPhrase != "Aspire"
        {
            completion(INSpeakableStringResolutionResult.needsValue())
            return;
        }
        let resolutionResult = INSpeakableStringResolutionResult.success(with: intent.organizationName!)
        completion(resolutionResult)
    }
    
    func resolveRequestedBalanceType(for intent: INSearchForAccountsIntent, with completion: @escaping (INBalanceTypeResolutionResult) -> Void) {
        if (intent.requestedBalanceType != .money)
        {
            completion(INBalanceTypeResolutionResult.needsValue())
            return;
        }
        let resolutionResult = INBalanceTypeResolutionResult.success(with: intent.requestedBalanceType)
        completion(resolutionResult)
    }


    func resolveAccountType(for intent: INSearchForAccountsIntent, with completion: @escaping (INAccountTypeResolutionResult) -> Void) {
        if intent.accountType != .saving{
            completion(INAccountTypeResolutionResult.needsValue())
            return;
        }

        let resolutionresult = INAccountTypeResolutionResult.success(with: INAccountType.saving)
        completion(resolutionresult);
    }
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent,
                                with completion: @escaping (INSpeakableStringResolutionResult) -> Void){
        if intent.accountNickname == nil
        {
            completion(INSpeakableStringResolutionResult.needsValue())
            return
        }
        let resolutionResult = INSpeakableStringResolutionResult.success(with: intent.accountNickname!)
        completion(resolutionResult)
    }
    
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
            localizedReason: "Unlock to show the balance",
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
