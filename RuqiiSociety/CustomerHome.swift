
//  CustomerHome.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 16/08/2017.
//  Copyright © 2017 Maha Alkathiery. All rights reserved.
//

import UIKit

class CustomerHome: UIViewController {

    var ViewAppearsAfterLogin = false
    var CustomerId = ""
    var CustomerEmail = ""
    var CustomerName = ""
    //var orders
    var CustomerPhone = ""
    var CustomerPrivatePhone = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (ViewAppearsAfterLogin == true){
            Utilities().ShowAlert(title: "تم تسجيل الدخول", msg:" في مجتمع رقي "+CustomerName+" أهلا بك مجددا ", vc: self)
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
    


}
