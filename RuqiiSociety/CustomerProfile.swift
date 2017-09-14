//  CustomerProfile.swift
//  RuqiiSociety
//  Created by  on 9/13/17.
//  Copyright © 2017 abdllah aljohar. All rights reserved.

import UIKit

class CustomerProfile: UIViewController {

    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.layer.cornerRadius = img.frame.size.height / 2.0
        img.layer.masksToBounds = true
        img.layer.borderWidth = 0
       
        // Do any additional setup after loading the view.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
