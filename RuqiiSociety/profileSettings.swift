
//  profileSettings.swift
//  RuqiiSociety
//  Created by  Maha Alkathiery on 05/08/2017.
//  Copyright © 2017 Maha Alkathiery All rights reserved.
///////

import UIKit
import Firebase
class profileSettings: UIViewController {

 
    @IBOutlet weak var confirmPasswordTxt: DesignableTextField!
    @IBOutlet weak var newPasswordTxt: DesignableTextField!
    @IBOutlet weak var currentPasswordTxt: DesignableTextField!
    @IBOutlet weak var phoneTxt: DesignableTextField!

    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var emailTxt: DesignableTextField!
    @IBOutlet weak var titleTxt: DesignableTextField!
    @IBOutlet weak var nameTxt: DesignableTextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "إعدادات الملف الشخصي"
        
        nameErrorLabel.isHidden = true
       
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
       nameTxt.text = ExpertInformation.ExpertName
        titleTxt.text = ExpertInformation.ExpertTitle
        emailTxt.text = ExpertInformation.ExpertEmail
        phoneTxt.text = ExpertInformation.ExpertPhone
        currentPasswordTxt.text = ExpertInformation.ExpertPassword
        
        
        // Do any additional setup after loading the view.
    }
    func checkName()-> Bool{
    
        if (nameTxt.text?.isEmpty)!{
            self.nameTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            nameErrorLabel.text = "الرجاء تعبئة الإسم"
            nameErrorLabel.isHidden = false
            return false
        }
        
        // this line to extract all numbers (if exist) in name string
        let testName = nameTxt.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        // test the name if it contains special characters
        let characterSet:NSCharacterSet = NSCharacterSet(charactersIn: "@!$%#^&*()?/.,\"[]{}':;|><=+\\±§،")
        
        if(testName != "" || self.nameTxt.text?.rangeOfCharacter(from: characterSet as CharacterSet) != nil){
           
            self.nameTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            nameErrorLabel.text = "الرجاء كتابة الإسم بشكل صحيح"
            nameErrorLabel.isHidden = false
            return false
        }
        else{
          
            self.nameTxt.backgroundColor = UIColor.white
            nameErrorLabel.isHidden = true
            return true
            
        }
        
      
    
    
    }// end of check Name function
    
    func checkPhone()-> Bool{
        
     
        
        if (phoneTxt.text?.isEmpty)!{
           
            self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء تعبئة رقم الهاتف"
            phoneErrorLabel.isHidden = false
            print("empty phone")
            return false
            
        }
        let testPhone = phoneTxt.text?.components(separatedBy: CharacterSet.letters.inverted).joined(separator: "")
        
        if(testPhone?.isEmpty == false){
            
            self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء كتابة رقم الجوال بشكل صحيح"
            phoneErrorLabel.isHidden = false
            return false
        }
        if (phoneTxt.text?.characters.count != 10){
           
            self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "رقم الجوال يجب أن يكون ١٠ خانات"
            phoneErrorLabel.isHidden = false
            return false
        }
        if (phoneTxt.text?.hasPrefix("05") == false ){
            
            if (phoneTxt.text?.hasPrefix("٠٥") == false){
                print ("phone error")
                self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                phoneErrorLabel.text = "رقم الجوال يجب أن يبدأ بـ 05"
                phoneErrorLabel.isHidden = false
               
            }
             return false
        }
        
    
        else {
            phoneErrorLabel.isHidden = true
            self.phoneTxt.backgroundColor = UIColor.white
            return true
        }
        
      
        
    }// end of checkPhone function
    
    
    
    @IBAction func saveBtnClicked(_ sender: Any) {
    
       var NoErrorFoundFlag = true
        var NoChangesMadeFlag = true
        var nameChanged = false
        var phoneChanged = false
        var passwordChanged = false
        if(nameTxt.text != ExpertInformation.ExpertName)
        {
            if (checkName()){
             //DB
                
          
            NoChangesMadeFlag = false
            nameChanged = true
            }
            
            else{
            NoErrorFoundFlag = false
                
            }
           
        }
        
        if (phoneTxt.text != ExpertInformation.ExpertPhone){
            if(checkPhone()){
            //DB
            ExpertInformation.ExpertPhone = phoneTxt.text
                NoChangesMadeFlag = false
                phoneChanged = true
            }
                
            else{
                NoErrorFoundFlag = false
            }

        
        }
        
        if (NoErrorFoundFlag == true){
            
           // let updatedExpert : [String : String] = ["name" : nameTxt.text!]
            if (nameChanged){
            Database.database().reference().child("Experts").child(ExpertInformation.ExpertId).updateChildValues(["name": nameTxt.text ?? ExpertInformation.ExpertName])
            ExpertInformation.ExpertName = nameTxt.text
            }
            
            if (phoneChanged){
                Database.database().reference().child("Experts").child(ExpertInformation.ExpertId).updateChildValues(["phone": phoneTxt.text ?? ExpertInformation.ExpertPhone])
                ExpertInformation.ExpertPhone = phoneTxt.text
            
            }
          /*  if(passwordChanged){
            //DB change password
              //  Database.database().reference().child("Experts").child(ExpertInformation.ExpertId).changePassword({ email: ExpertInformation.ExpertEmail ,oldPassword: currentPasswordTxt.text,newassword: newPasswordTxt.text })
                
                 /*Database.database().reference().child(Experts").child(ExpertInformation.ExpertId).changePassword(newPasswordTxt.text)
            */
            
            }*/
        }
         if (NoChangesMadeFlag == true){
        
            
            Utilities().ShowAlert(title:"",msg:"لم يتم العثور على تغييرات", vc: self , NextView: "backToSettings")
              
                          }
        else
         {
          Utilities().ShowAlert(title:"",msg:"تم حفظ التغييرات", vc: self , NextView: "backToSettings")
        }
    
 
 
    }//end of saveBtnClicked action
    
    
    @IBAction func checkBoxIsClicked(_ sender: UIButton) {
        
           Utilities().checkBox(sender: sender)
        
    }//end of checkBoxIsClicked action
    

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
