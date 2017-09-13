
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
var ViewAppearsAfterSettings = false
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

    
    if (ViewAppearsAfterLogin == true  ){
        
    let firstName = ExpertInformation.ExpertName.components(separatedBy:" ").first
        Utilities().ShowAlert(title:"تم تسجيل الدخول",msg:" أهلا بك مجددا "+firstName!+" في مجتمع رقي  ", vc: self ,NextView: "")}

        if (ViewAppearsAfterLogin == true ||  ViewAppearsAfterSettings == true ){
            
                       fullNameLabel.text = ExpertInformation.ExpertName
            ratingCountsLabel.text = String(ExpertInformation.ExpertNumOfRating ?? 0)
            titleLabel.text = ExpertInformation.ExpertTitle
            pendingOrdersCountLabel.text =  String(ExpertInformation.ExpertPendingOrdersCount ?? 0)
            completedOrdersCountLabel.text = String(ExpertInformation.ExpertCompletedOrdersCount ?? 0)
                  }
    if (self.navigationController?.isNavigationBarHidden == false){
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    }
   
    }
    
    
    @IBAction func settingsClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settings", sender: self)
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    

}//  end of the class
