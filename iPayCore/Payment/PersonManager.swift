//
//  PersonManager.swift
//  iPay
//
//  Created by Ramesh on 24/11/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation
import Intents

public class PersonManager : NSObject
{
    let payeeProvider = PayeeProvider()
    
    public override init()
    {
        super.init()
    }
    
    public func getPersons() -> [PersonEntity]
    {
        var persons : [PersonEntity] = []
        
        if payeeProvider.getPayeesCount() == 0
        {
            let person1 = PersonEntity (displayName: "John Cena", accountNumber: "1111111111", firstName: "Jhon", lastName: "David", dateOfBirth: "25/06/1990", age: "26", profileIcon : "profile1.jpeg")
            
            let person2 = PersonEntity (displayName: "David", accountNumber: "2222222222", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile2.jpeg")
            
            let person3 = PersonEntity (displayName: "John David", accountNumber: "3333333333", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile3.jpeg")
            
//            let person4 = PersonEntity (displayName: "Ari", accountNumber: "4444444444", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile4.jpeg")
            
            let person5 = PersonEntity (displayName: "Alex", accountNumber: "5555555555", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile5.jpeg")
            
//            let person6 = PersonEntity (displayName: "Aswin", accountNumber: "6666666666", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile6.jpeg")
            
            let person7 = PersonEntity (displayName: "Clark", accountNumber: "7777777777", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile7.jpeg")
            
            let person8 = PersonEntity (displayName: "Matthew", accountNumber: "8888888888", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile8.jpeg")
            
            let person9 = PersonEntity (displayName: "Morgan", accountNumber: "9999999999", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile9.jpeg")
            
            let person10 = PersonEntity (displayName: "Michael", accountNumber: "1111122222", firstName: "David", lastName: "John", dateOfBirth: "25/06/1990", age: "26",profileIcon : "profile10.jpeg")
            
            persons.append(person1)
            persons.append(person2)
            persons.append(person3)
//            persons.append(person4)
            persons.append(person5)
//            persons.append(person6)
            persons.append(person7)
            persons.append(person8)
            persons.append(person9)
            persons.append(person10)
            payeeProvider.addPayee(payee: person1)
            payeeProvider.addPayee(payee: person2)
            payeeProvider.addPayee(payee: person3)
//            payeeProvider.addPayee(payee: person4)
            payeeProvider.addPayee(payee: person5)
//            payeeProvider.addPayee(payee: person6)
            payeeProvider.addPayee(payee: person7)
            payeeProvider.addPayee(payee: person8)
            payeeProvider.addPayee(payee: person9)
            payeeProvider.addPayee(payee: person10)
        }
        else
        {
            persons = payeeProvider.fetchPayees()!
        }
        return persons
    }  
    
    public func matchedPersons( displayName : String) ->  [PersonEntity]
    {
        var machedPersons : [PersonEntity] = []
        
        for person in self.getPersons()
        {
            if person.displayName.contains(displayName)
            {
                machedPersons.append(person)
            }
        }
        return machedPersons
    }
    
    public func isPerson( person : PersonEntity) -> INPerson
    {
        let personHandule : INPersonHandle = INPersonHandle(value: person.accountNumber, type:INPersonHandleType.unknown)
        
        let nameFormatter = PersonNameComponentsFormatter()
        let nameComponents = nameFormatter.personNameComponents(from: person.displayName)
        
        return INPerson (personHandle: personHandule, nameComponents: nameComponents, displayName: person.displayName, image: nil, contactIdentifier: person.accountNumber, customIdentifier: nil, aliases: nil, suggestionType: INPersonSuggestionType.socialProfile)
    }
}
