//  profileSettings.swift
//  RuqiiSociety
//  Created by  Maha Alkathiery on 05/08/2017.
//  Copyright © 2017 Maha Alkathiery All rights reserved.


import UIKit
import Firebase

class profileSettings: UIViewController {
    
    // Declaring the components of profileSettings interface
    
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
    
    // Declaring the class variables
    
    var currentCheckBoxImage = UIImage (named: "unchecked")
    var emptyPasswordFields = false
    
    
    // Checking the validity of name input
    
    func checkName()-> Bool{
        
        // Checking if the name text field is empty.If yes, the change will be rejected and proper error message will appear.
        
        if (nameTxt.text?.isEmpty)!{
            
            self.nameTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            nameErrorLabel.text = "الرجاء تعبئة الإسم"
            nameErrorLabel.isHidden = false
            return false
        }
        
        // Extracting all found numbers in the name (if exist) and saving them in testName constant
        
        let testName = nameTxt.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        // Declaring the set of characters that are not allowed to be used within name input
        
        let characterSet:NSCharacterSet = NSCharacterSet(charactersIn: "@!$%#^&*()?/.,\"[]{}':;|><=+\\±§،")
        
        // Checking if the name contains any special character or numbers.If exist, the change will be rejected and proper error message will appear
        
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
        
        
    }// End of checkName function
    
    // Checking the validity of password input
    
    func checkPassword()-> Bool {
        var NoPasswordError = true
        
        // Checking if both text fields are empty.
        if (newPasswordTxt.text?.isEmpty == true && confirmPasswordTxt.text?.isEmpty == true){
            
            emptyPasswordFields = true
            NoPasswordError = true
        }
         // Checking if both text fields newPasswordTxt and confirmPasswordTxt contain a text and they are not empty
        else if (newPasswordTxt.text?.isEmpty == false && confirmPasswordTxt.text?.isEmpty == false)
        {
            // Checking if the text fields contain different text. If yes, the change will be rejected and proper error message will appear
            
            if(confirmPasswordTxt.text != newPasswordTxt.text){
                
                newPasswordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                confirmPasswordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                passwordErrorLabel.isHidden = false
                passwordErrorLabel.text = "كلمات المرور المدخلة غير متطابقة"
                NoPasswordError = false
            }
                
                // Checking the length of the entered password if it is between 0 and 5.If yes,the change will be rejected and proper error message will appear
                
            else if((newPasswordTxt.text?.characters.count)! <= 5 && (newPasswordTxt.text?.characters.count)! != 0){
                
                newPasswordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                confirmPasswordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                passwordErrorLabel.isHidden = false
                passwordErrorLabel.text =  "كلمة المرور يجب أن تكون أكثر من ٥ حروف "
                NoPasswordError = false
            }
            
            
        }
            
            // Checking if newPasswordTxt text field is empty.If yes, the change will be rejected and proper error message will appear
            
            
        else if (newPasswordTxt.text?.isEmpty == true && confirmPasswordTxt.text?.isEmpty == false){
            
            newPasswordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text = "الرجاء تعبئة الحقل المشار إليه"
            NoPasswordError = false
            
            
        }
            
            // Checking if confirmPasswordTxt text field is empty.If yes,the change will be rejected and proper error message will appear
            
        else if (newPasswordTxt.text?.isEmpty == false && confirmPasswordTxt.text?.isEmpty == true){
            
            confirmPasswordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text = "الرجاء تعبئة الحقل المشار إليه"
            NoPasswordError = false
            
        }
            
          
            
     
            
        else  {
            NoPasswordError = true
        }
        
        return  NoPasswordError
        
    }// End of checkPassword function
    
    // Checking the validity of phone input
    
    func checkPhone()-> Bool{
        
        // Checking if phoneTxt text field is empty.If yes,the change will be rejected and proper error message will appear
        
        if (phoneTxt.text?.isEmpty)!{
            
            self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء تعبئة رقم الهاتف"
            phoneErrorLabel.isHidden = false
            return false
            
        }
        
        // Extracting all found letters in the phone (if exist) and saving them in testPhone constant
        
        let testPhone = phoneTxt.text?.components(separatedBy: CharacterSet.letters.inverted).joined(separator: "")
        
        // Declaring a constant to hold the rejected character set
        
        let characterSet:NSCharacterSet = NSCharacterSet(charactersIn: "@!$%#^&*()?/.,\"[]{}':;|><=+\\±§،")
        
        // Checking if the phone contains any special character or letters.If exist, the change will be rejected and proper error message will appear
        
        if(testPhone?.isEmpty == false || phoneTxt.text?.rangeOfCharacter(from: characterSet as CharacterSet) != nil){
            
            self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء كتابة رقم الجوال بشكل صحيح"
            phoneErrorLabel.isHidden = false
            return false
        }
        
        // Checking the length of the entered phone if it is not equal to 10 digits.If yes,the change will be rejected and proper error message will appear
        
        if (phoneTxt.text?.characters.count != 10){
            
            self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "رقم الجوال يجب أن يكون ١٠ خانات"
            phoneErrorLabel.isHidden = false
            return false
        }
        
        // Checking if the phone does not start with 05 or  .If yes,the change will be rejected and proper error message will appear
        
        if (phoneTxt.text?.hasPrefix("05") == false ){
            
            if (phoneTxt.text?.hasPrefix("٠٥") == false){
                
                self.phoneTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                phoneErrorLabel.text = "رقم الجوال يجب أن يبدأ بـ 05"
                phoneErrorLabel.isHidden = false
                return false
            }
            else {
                return true
            }
        }
            
            
        else {
            phoneErrorLabel.isHidden = true
            self.phoneTxt.backgroundColor = UIColor.white
            return true
        }
        
        
        
    }// end of checkPhone function
    
    func clearAll(){
        
        phoneTxt.backgroundColor = UIColor.white
        phoneErrorLabel.text = " "
        phoneErrorLabel.isHidden = true
        nameTxt.backgroundColor = UIColor.white
        nameErrorLabel.text = " "
        nameErrorLabel.isHidden = true
        newPasswordTxt.backgroundColor = UIColor.white
        confirmPasswordTxt.backgroundColor = UIColor.white
        passwordErrorLabel.text = " "
        passwordErrorLabel.isHidden = true
        
        
        
        
    }//end of clearAll function
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        clearAll()
        var NoErrorFoundFlag = true
        var NumberOfChanges = 0
        var nameChanged = false
        var phoneChanged = false
        var passwordChanged = false
        
        //checking if the user's information have been changed
        
        if(nameTxt.text != ExpertInformation.ExpertName)
        {
            //check if the name change is valid or not
            if (checkName()){
                
                
                nameChanged = true
            }
                
            else{
                NoErrorFoundFlag = false
                
            }
            
            
        }
        
        if (phoneTxt.text != ExpertInformation.ExpertPhone){
            
            //check if the phone change is valid or not
            if(checkPhone()){
                
                phoneChanged = true
            }
                
            else{
                NoErrorFoundFlag = false
            }
            
            
            
        }
        
        if ((newPasswordTxt.text != ExpertInformation.ExpertPassword && newPasswordTxt.text?.isEmpty == false) || (confirmPasswordTxt.text != ExpertInformation.ExpertPassword && confirmPasswordTxt.text?.isEmpty == false) ){
            //check if the password change is valid or not
            if(checkPassword()){
                
                
                passwordChanged = true
            }
                
            else{
                NoErrorFoundFlag = false
            }
            
            
        }
        
        // Settings the user's information based on the changed values
        
        if (NoErrorFoundFlag == true){
            
            if (checkBoxBtn.currentImage != currentCheckBoxImage){
                Database.database().reference().child("Experts").child(ExpertInformation.ExpertId).updateChildValues(["isPhonePrivate": !(ExpertInformation.ExpertIsPhonePrivate!)])
                NumberOfChanges += 1
            }
            
            
            
            if (nameChanged){
                
                Database.database().reference().child("Experts").child(ExpertInformation.ExpertId).updateChildValues(["name": nameTxt.text ])
                ExpertInformation.ExpertName = nameTxt.text
                NumberOfChanges += 1
            }
            
            if (phoneChanged){
                Database.database().reference().child("Experts").child(ExpertInformation.ExpertId).updateChildValues(["phone": phoneTxt.text])
                ExpertInformation.ExpertPhone = phoneTxt.text
                NumberOfChanges += 1
                
            }
            
            if(passwordChanged && emptyPasswordFields == false){
                NumberOfChanges += 1
                Auth.auth().currentUser?.updatePassword(to: newPasswordTxt.text!) { (error) in
                    
                    if (error != nil){
                        
                        Utilities().ShowAlert(title:"",msg:"حدث خطأ خلال تغيير كلمة المرور ", vc: self , NextView: "")
                        
                        return
                    }
                    else {
                        ExpertInformation.ExpertPassword = self.newPasswordTxt.text
                        
                    }
                    
                    
                }
                
                
                
                
                
            }
            
        }
        
        if ( NumberOfChanges == 0 && NoErrorFoundFlag == false){
            return
        }
            
        else if ( NumberOfChanges > 0 && NoErrorFoundFlag == true){
            
            
            
            Utilities().ShowAlert(title:"",msg:"تم حفظ التغييرات", vc: self , NextView: "backToSettings")
            
        }
            
        else if ( (NumberOfChanges == 0 && NoErrorFoundFlag == true) || (NumberOfChanges == 0 && NoErrorFoundFlag == true && emptyPasswordFields == true )){
            
            Utilities().ShowAlert(title:"",msg:"لم يتم العثور على تغييرات", vc: self , NextView: "backToSettings")
        }
        
        
        
        
    }//end of saveBtnClicked action
    
    
    @IBAction func checkBoxIsClicked(_ sender: UIButton) {
        
        Utilities().checkBox(sender: sender)
        
    }//end of checkBoxIsClicked action
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "إعدادات الملف الشخصي"
        
        // Hide error labels when first the interface is loaded
        
        nameErrorLabel.isHidden = true
        phoneErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        // Displaying the expert information on the interface components
        
        nameTxt.text =  ExpertInformation.ExpertName
        titleTxt.text =  ExpertInformation.ExpertTitle!
        emailTxt.text = ExpertInformation.ExpertEmail
        phoneTxt.text = ExpertInformation.ExpertPhone
        currentPasswordTxt.text =   "كلمة المرور الحالية : " + ExpertInformation.ExpertPassword
        if (ExpertInformation.ExpertIsPhonePrivate == false){
            
            checkBoxBtn.setImage(UIImage(named:"unchecked"), for: [])
            currentCheckBoxImage = UIImage(named:"unchecked")
        }
        else {
            
            checkBoxBtn.setImage(UIImage(named:"checked"), for: [])
            currentCheckBoxImage = UIImage(named:"checked")
        }
        
        
        // Do any additional setup after loading the view.
    } // End of viewDidLoad function
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}// End of profileSettings class
