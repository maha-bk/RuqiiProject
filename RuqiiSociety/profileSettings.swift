
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
    
    @IBOutlet weak var nameTxt: DesignableTextField!
 
   
    @IBOutlet weak var emailTxt: DesignableTextField!
  
    @IBOutlet weak var phoneTxt: DesignableTextField!
    
    @IBOutlet weak var confirmPasswordTxt: DesignableTextField!
    @IBOutlet weak var newPasswordTxt: DesignableTextField!
    
    @IBOutlet weak var currentPasswordTxt: DesignableTextField!
    
    @IBOutlet weak var titleTxt: DesignableTextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var titleErrorLabel: UILabel!
    
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    

    
    @IBOutlet weak var phoneErrorLabel: UILabel!
    
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "إعدادات الملف الشخصي"
         titleErrorLabel.isHidden = true
        nameErrorLabel.isHidden = true
       
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        nameTxt.text = ExpertInformation.ExpertName
        titleTxt.text = ExpertInformation.ExpertTitle
        emailTxt.text = ExpertInformation.ExpertEmail
        phoneTxt.text = ExpertInformation.ExpertPhone
        currentPasswordTxt.text = ExpertInformation.ExpertPassword
        
        currentPasswordTxt.isEnabled = false
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
