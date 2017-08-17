
//  ExpertHome.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 13/08/2017.
//  Copyright © 2017 Maha Alkatheiry. All rights reserved.

import UIKit
import Firebase
import FirebaseDatabase
import Foundation
class ExpertHome: UIViewController {
    
var ViewAppearsAfterLogin = false
 var ExpertId = ""
 var ExpertbankName = ""
 //var ExpertServices = ""
 //var ExpertCompletedOrders = -1
 var ExpertEmail = ""
 var ExperIban = ""
 var ExpertPrivatePhone = true
 var ExpertName = ""
 var ExpertNumOfRating = 0
 //var ExpertPendingOrders = 0
 var ExpertPhone = ""
 //var ExpertPortFolio
 //var ExpertRating = 0
 //var ExpertRatingPoint: Int
 var ExpertTitle = ""
    
    @IBOutlet weak var pendingOrdersCountLabel: UILabel!

    @IBOutlet weak var completedOrdersCountLabel: UILabel!
    @IBOutlet weak var ratingCountsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var newOrdersIcon: UIImageView!

   override func viewWillAppear(_ animated: Bool) {
        if (ViewAppearsAfterLogin == true){
            Utilities().ShowAlert(title: "تم تسجيل الدخول", msg:" في مجتمع رقي "+ExpertName+" أهلا بك مجددا ", vc: self)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

/* Servicesaddclose
 bankName:
 "مصرف الراجحي"
 completed_orders
 email:
 "3boorah.2014@gmail.com"
 iban:
 "SA6543212345678987654345"
 isPhonePrivate:
 false
 name:
 "عبير الشهري"
 numOfRating:
 1
 pending_orders
 phone:
 "0569875369"
 portfolio
 rating:
 3.5
 ratingPoints:
 3.5
 title:
 " مبرمجة"
*/
}//  end of the class
