
//  ExpertInformation.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 8/19/17.
//  Copyright © 2017 Maha Alkathjeiry. All rights reserved.

import Foundation
import Firebase
import FirebaseDatabase

/* This struct responsible of loading the expert information after successful sign in .Variables with question mark mean that they are optional.Variables with exclamation mark mean that
  they are must (non optional) . All the variables in this struct can be accessed globaly in any class in the project by using the structName.variableName . Ex: ExpertInformation.ExpertName */

struct ExpertInformation {
    
    
   static var ExpertName: String!
   static var ExpertEmail: String!
   static var ExpertPhone: String!
   static var ExpertId: String!
   static var ExpertBankName : String!
   static var ExpertIban: String!
   static var ExpertIsPhonePrivate: Bool!
   static var ExpertNumOfRating: Int?
   static var ExpertTitle: String?
   static var ExpertCompletedOrdersCount: Int?
   static var ExpertPendingOrdersCount: Int?
   static var ExpertCompletedOrdersDic: [String:Bool]?
   static var ExpertPendingOrdersDic: [String:Bool]?
   static var ExpertPortfolioDic: [String: String]?
   static var ExpertServicesDic: [String]?
    
    
   // The following function acts as an initializer
    
    static func loadExpertInfo(snapshot: DataSnapshot,expertId: String){
    
   ExpertInformation.ExpertId = expertId
    
        // Setting the values for non optional global variables
    
  
    

        
        
        ExpertInformation.ExpertName = (snapshot.value! as! NSDictionary)["name"] as! String
        ExpertInformation.ExpertEmail = (snapshot.value! as! NSDictionary)["email"] as! String
        ExpertInformation.ExpertPhone = (snapshot.value! as! NSDictionary)["phone"] as! String
        ExpertInformation.ExpertBankName = (snapshot.value! as! NSDictionary)["bankName"] as! String
        ExpertInformation.ExpertIban = (snapshot.value! as! NSDictionary)["iban"] as! String
        ExpertInformation.ExpertIsPhonePrivate = (snapshot.value! as! NSDictionary)["isPhonePrivate"] as! Bool
        
        
        // Setting the values for optional global variables
        
        let temp1 = (snapshot.value! as! NSDictionary)["numOfRating"] as? Int
        if (temp1 != nil){
            ExpertInformation.ExpertNumOfRating = temp1
        }
        else {ExpertInformation.ExpertNumOfRating = 0}
        
        let temp2 = (snapshot.value! as! NSDictionary)["title"] as? String
        if (temp2 != nil){
            ExpertInformation.ExpertTitle = temp2
        }
        else { ExpertInformation.ExpertTitle = signupStep3.expertTitleString}
        let temp3 = (snapshot.childSnapshot(forPath:"completed_orders").value) as? [String: Bool]
        if (temp3 != nil){ExpertInformation.ExpertCompletedOrdersDic = temp3}
        else {ExpertInformation.ExpertCompletedOrdersDic = [String: Bool]()}
        
        let temp4 = (snapshot.childSnapshot(forPath:"pending_orders").value) as? [String: Bool]
        if (temp4 != nil){ExpertInformation.ExpertPendingOrdersDic = temp4}
        else {ExpertInformation.ExpertPendingOrdersDic = [String: Bool]()}
        
        let temp5 = (snapshot.childSnapshot(forPath:"portfolio").value) as? [String: String]
        if (temp5 != nil) {ExpertInformation.ExpertPortfolioDic = temp5}
        else {ExpertInformation.ExpertPortfolioDic = [String: String]()}
        
        let temp6 = (snapshot.childSnapshot(forPath:"Services").value) as? [String]
        if(temp6 != nil) {ExpertInformation.ExpertServicesDic = temp6}
        else {ExpertInformation.ExpertServicesDic = [String]()}
        
        let temp7 = Int(snapshot.childSnapshot(forPath:"completed_orders").childrenCount)
        if(temp7 != 0){
        ExpertInformation.ExpertCompletedOrdersCount = temp7
        }
        else{ExpertInformation.ExpertCompletedOrdersCount = 0}
        
        let temp8 = Int(snapshot.childSnapshot(forPath:"pending_orders").childrenCount)
        if(temp8 != 0){
            ExpertInformation.ExpertPendingOrdersCount = temp8
        }
        else{ExpertInformation.ExpertPendingOrdersCount = 0}
        
   
    
    
    
    
    }//end of LoadExpertInfo function

    
       
}// end of ExpertInformation struct
