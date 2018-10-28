//
//  IntentViewController.swift
//  iPayIntentExtensionUI
//
//  Created by Ramesh on 24/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import IntentsUI
import iPayCore

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet var profileIcon: UIImageView!
    @IBOutlet var payeeName: UILabel!
    @IBOutlet var payeeAccNo: UILabel!
    
    let personManager : PersonManager = PersonManager()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - INUIHostedViewControlling
    
    func configure(with interaction: INInteraction, context: INUIHostedViewContext, completion: ((CGSize) -> Void))
    {
        if let sendIntent = interaction.intent as? INSendPaymentIntent
        {
            if let payee = sendIntent.payee
            {
                payeeName.text = payee.displayName
                
                let persons : [PersonEntity] = personManager.getPersons()
                
                for person in persons
                {
                    if person.displayName == payee.displayName
                    {
                        payeeAccNo.text = person.accountNumber
                        profileIcon.image = UIImage(named: person.profileIcon)
                    }
                }
            }
            completion(self.desiredSize)
        }
        else
        {
            completion(self.desiredSize)
        }
    }
    
    var desiredSize: CGSize
    {
        return self.extensionContext!.hostedViewMinimumAllowedSize
    }
    
    var displaysPaymentTransaction: Bool {
        return true
    }
}
