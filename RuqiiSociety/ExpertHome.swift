
//  ExpertHome.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 13/08/2017.
//  Copyright © 2017 Maha Alkatheiry . All rights reserved.

import UIKit
import Firebase
import FirebaseDatabase
import Foundation
class ExpertHome: UIViewController {
    
var ViewAppearsAfterLogin = false
var ViewAppearsAfterSignup = false
    @IBOutlet weak var pendingOrdersCountLabel: UILabel!

   
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var completedOrdersCountLabel: UILabel!
    @IBOutlet weak var ratingCountsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    var userId = String ()
    var expertTit = String ()
    var ref: DatabaseReference! 
    
    

   override func viewWillAppear(_ animated: Bool) {
    /*
        if (ViewAppearsAfterLogin == true || ViewAppearsAfterSignup == true){
            let firstName = ExpertInformation.ExpertName!.components(separatedBy:" ").first
            Utilities().ShowAlert(title:"تم تسجيل الدخول",msg:" أهلا بك مجددا "+firstName!+" في مجتمع رقي  ", vc: self)
                  }
 */
   fullNameLabel.text = ExpertInformation.ExpertName
    }
    
    
    @IBAction func settingsClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settings", sender: self)
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
         //ExpertInformation.loadExpertInfo(expertId: self.userId)
       //print(expertTit)
        /*Database.database().reference().child("Experts").queryOrderedByKey().queryEqual(toValue: userId).observe(.value, with: { (DataSnapshot) in
            
            if(DataSnapshot.exists()){
                self.ref.child("Experts").child(self.userId).child("title").setValue(self.expertTit)

        }
            else{
                print("Not exist")
            }
        })*/
       
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    

}//  end of the class
