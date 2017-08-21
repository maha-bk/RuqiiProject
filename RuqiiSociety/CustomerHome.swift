
//  CustomerHome.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 16/08/2017.
//  Copyright © 2017 Maha Alkathiery. All rights reserved.

import UIKit

class CustomerHome: UIViewController {

    var ViewAppearsAfterLogin = false
 
    @IBOutlet weak var customerNameLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        if (ViewAppearsAfterLogin == true){
        
                let firstName = CustomerInformation.CustomerName.components(separatedBy:" ").first
                Utilities().ShowAlert(title:"تم تسجيل الدخول",msg:" أهلا بك مجددا "+firstName!+" في مجتمع رقي  ", vc: self)
         customerNameLabel.text = CustomerInformation.CustomerName
        }
        
    }// end of ViewWillAppear function

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }// end of viewDidLoad function

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }// end of idReceiveMemoryWarning function
    


}// end of CustomerHome class
