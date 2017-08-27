
//  profileSettings.swift
//  RuqiiSociety
//  Created by  Maha Alkathiery on 05/08/2017.
//  Copyright © 2017 Maha Alkathiery All rights reserved.
//

import UIKit

class profileSettings: UIViewController {
    
    var checkbox = UIImage(named: "checked")
    var uncheckbox = UIImage(named: "unchecked")
    var isButtonClicked = Bool()
    
    @IBOutlet weak var checkBoxBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "إعدادات الملف الشخصي"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkBoxBtnIsClicked(_ sender: UIButton) {
      
        func clickedCheckbox() {
            
            
            if (isButtonClicked == true){
                isButtonClicked = false
            }
            else{
               isButtonClicked  = true
            }
            
            if (isButtonClicked == true){
               sender.setImage(checkbox, for: UIControlState.normal)
            }
            else{
                sender.setImage(uncheckbox, for: UIControlState.normal )
            }
        }
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
