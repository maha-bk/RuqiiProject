
//  ExpertHome.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 13/08/2017.
//  Copyright © 2017 Maha Alkatheiry. All rights reserved.

import UIKit
import Firebase
import FirebaseDatabase

class ExpertHome: UIViewController {
    
/*var ViewAppearsAfterLogin = false
 var ExpertId: String
 var ExpertbankName: String
 //var ExpertServices: String
 var ExpertCompletedOrders: Int
 var ExpertEmail: String
 var ExperIban: String
 var ExpertPrivatePhone: Bool
 var ExpertName: String
 var ExpertNumOfRating:Int
 var ExpertPendingOrders: Int
 var ExpertPhone: String
 //var ExpertPortFolio
 var ExpertRating: Int
 //var ExpertRatingPoint: Int
 var ExpertTitle: String
    */
    @IBOutlet weak var pendingOrdersCountLabel: UILabel!

    @IBOutlet weak var completedOrdersCountLabel: UILabel!
    @IBOutlet weak var ratingCountsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var newOrdersIcon: UIImageView!
    
   /* init(snapshot: DataSnapshot){
    ExpertName = (snapshot.value! as! NSDictionary)["name"] as! String
    ExpertTitle = (snapshot.value! as! NSDictionary)["title"] as! String
    ExpertEmail = (snapshot.value! as! NSDictionary)["email"] as! String
    ExpertPhone = (snapshot.value! as! NSDictionary)["phone"] as! String
    ExpertRating = (snapshot.value! as! NSDictionary)["numOfRating"] as! Int
   
    
    }*/
    /*MAHA*/
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
  /*  override func viewWillAppear(_ animated: Bool) {
        if (ViewAppearsAfterLogin == true){
            Utilities().ShowAlert(title: "تم تسجيل الدخول", msg:" في مجتمع رقي "+ExpertName+" أهلا بك مجددا ", vc: self)
        }
        
    }*/
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    

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
