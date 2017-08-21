
//  CustomerInformation.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry  on 8/19/17.
//  Copyright © 2017 Maha Alkatheiry. All rights reserved.

import Foundation
import Firebase
import FirebaseDatabase

/* This struct responsible of loading the customer information after successful sign in .Variables with question mark mean that they are optional.Variables with exclamation mark mean that
 they are must (non optional) . All the variables in this struct can be accessed globaly in any class in the project by using the structName.variableName . Ex: CustomerInformation.CustomerName */

struct CustomerInformation {
    
    
    static var CustomerName: String!
    static var CustomerEmail: String!
    static var CustomerPhone: String!
    static var CustomerId: String!
    static var CustomerIsPhonePrivate: Bool!
    static var CustomerOrdersCount: Int?
    static var CustomerOrdersDic: [String:Bool]?
    
    
    // The following function acts as an initializer
    
    static func loadCustomerInfo(snapshot: DataSnapshot ,customerId: String){
        
        // Setting the values for non optional global variables
        
        CustomerInformation.CustomerName = (snapshot.value! as! NSDictionary)["name"] as! String
        ExpertInformation.ExpertEmail = (snapshot.value! as! NSDictionary)["email"] as! String
        ExpertInformation.ExpertPhone = (snapshot.value! as! NSDictionary)["phone"] as! String
        ExpertInformation.ExpertIsPhonePrivate = (snapshot.value! as! NSDictionary)["phonePrivate"] as! Bool
        
        
        // Setting the values for optional global variables
        
        
        let temp = (snapshot.childSnapshot(forPath:"orders").value) as? [String: Bool]
        if (temp != nil){CustomerInformation.CustomerOrdersDic = temp}
        else {CustomerInformation.CustomerOrdersDic = [String: Bool]()}
        
        CustomerInformation.CustomerOrdersCount = Int(snapshot.childSnapshot(forPath:"orders").childrenCount)
        
        
        
        
    }//end of LoadCustomerInfo function
    
    
    
}// end of CustomerInformation struct
