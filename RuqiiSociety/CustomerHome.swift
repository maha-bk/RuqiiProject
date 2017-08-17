
//  CustomerHome.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 16/08/2017.
//  Copyright © 2017 Maha Alkathiery. All rights reserved.
//

import UIKit

class CustomerHome: UIViewController {

    var ViewAppearsAfterLogin = false
    var CustomerId = ""
    
    override func viewWillAppear(_ animated: Bool) {
        if (ViewAppearsAfterLogin == true){
            Utilities().ShowAlert(title: "تم تسجيل الدخول", msg: "أهلا بك مجددا في مجتمع رقي", vc: self)
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
