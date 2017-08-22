
//  profileSettings.swift
//  RuqiiSociety
//  Created by  Maha Alkathiery on 05/08/2017.
//  Copyright © 2017 Maha Alkathiery All rights reserved.
//

import UIKit

class profileSettings: UIViewController {
    
    @IBOutlet weak var checkBoxBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkBoxBtnIsClicked(_ sender: UIButton) {
        
     //   Utilities.clickedCheckbox(_ sender)
    }
    override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.title = "إعدادات الملف الشخصي"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
