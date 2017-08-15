// SignIn.swift
//  RuqiiSociety
//  Created by Maha alkatheiry on 24/07/2017.
//  Copyright © 2017 Maha alkatheiry. All rights reserved.


import UIKit
import Firebase
class SignIn: UIViewController {
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var emptyFieldsErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    var emailErrorFlag = false
    var passwordErrorFlag = false

    func clearLabelsWithflushing(){
        self.emailErrorLabel.isHidden = true
        self.emailErrorLabel.text =  " "
        self.passwordErrorLabel.isHidden = true
        self.passwordErrorLabel.text =  " "
        
    }//end of clearLabelsWithFlushing function
    
    
    func clearEmailErrorLabel(){
        emailTxt.backgroundColor = UIColor.white
        emailErrorLabel.isHidden = true
        emailErrorLabel.text =  " "
        
        
    }//end of clearEmailErrorLabel function to clear the label when needed
    
    func clearPasswordErrorLabel(){
        passwordTxt.backgroundColor = UIColor.white
        passwordErrorLabel.isHidden = true
        passwordErrorLabel.text =  " "
        
    }//end of clearPasswordErrorLabel function to clear the label when needed
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let NextView = segue.destination as! ExpertHome
        NextView.ViewAppearsAfterLogin = true
    }
    
  
    
    func checkIfAllAreEmpty() -> Bool{
        if ((emailTxt.text?.isEmpty)! && (passwordTxt.text?.isEmpty)!)
        {
            emailTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passwordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            emptyFieldsErrorLabel.isHidden = false
            emptyFieldsErrorLabel.text = "الرجاء تعبئة جميع الحقول"
            clearLabelsWithflushing()
           
            return true
        }// checking if all the fields are empty
        else {
            emptyFieldsErrorLabel.isHidden = true
            emptyFieldsErrorLabel.text = ""
            clearEmailErrorLabel()
            clearPasswordErrorLabel()
            
            return false
        }

    
    }
    func checkIfOneIsEmpty() -> Bool{
        
        var returnValue = false
        
        if ((emailTxt.text?.isEmpty)!  || (passwordTxt.text?.isEmpty)!){
            
            if ((emailTxt.text?.isEmpty)! ){
                emailTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                
                emailErrorLabel.isHidden = false
                emailErrorLabel.text =  "الرجاء تعبئة البريد الإلكتروني "
                checkPassword()
                returnValue = true
            }
                
            else {
                clearEmailErrorLabel()
                
                  returnValue = false
            }
            
            
            if ((passwordTxt.text?.isEmpty)! )
            {
                passwordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                
                passwordErrorLabel.isHidden = false
                passwordErrorLabel.text =  " الرجاء تعبئة كلمة المرور"
                checkEmailPattern()
                
                  returnValue = true
            }
            else {
                
                clearPasswordErrorLabel()
                
                  returnValue = false
            }
            
            
        }//checking if one of the fields is empty

    return returnValue
    }
    
    func checkEmailPattern(){
        
        if(emailTxt.text?.isEmpty)!{
            emailTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            
            emailErrorLabel.isHidden = false
            emailErrorLabel.text =  "الرجاء تعبئة البريد الإلكتروني "
        }
        else{
        let email = emailTxt.text
        let flag = isValidEmailAddress(emailAddressString: email!)
        
        if (flag == false){
            self.emailErrorLabel.isHidden = false
            self.emailTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            self.emailErrorLabel.text =  "الرجاء كتابة البريد الالكتروني بصيغة صحيحة."
            self.emailErrorFlag = true
        }
        else{
            
            clearEmailErrorLabel()
            self.emailErrorFlag = false
        }
        
        }
    }

   func isValidEmailAddress(emailAddressString: String) -> Bool {
     
        var returnValue = true
       
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }

    
    
    func checkAccount() {
        
        let email = emailTxt.text
        let password = passwordTxt.text
                Auth.auth().signIn(withEmail: email!, password: password!, completion: {(user, error) in
                    if (user != nil) {
                      
                         self.performSegue(withIdentifier: "ExpertHome", sender: self)
                                                        }
                   
                    
                        if let errorMessage = error {
                            
                            print(errorMessage.localizedDescription)
                            
                            if(errorMessage.localizedDescription.description.contains("There is no user record corresponding to this identifier. The user may have been deleted.")){
                                self.emptyFieldsErrorLabel.isHidden = false
                                self.emailTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                                self.passwordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                                self.emptyFieldsErrorLabel.text = "لا يوجد مستخدم بهذه المعلومات. الرجاء التحقق مرة أخرى."
                                self.clearLabelsWithflushing()
                               
                                
                               
                                
                            }
                          
                            if(errorMessage.localizedDescription.description.contains("The password is invalid or the user does not have a password.")){
                                
                                self.passwordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                                self.passwordErrorLabel.isHidden = false
                                self.passwordErrorLabel.text = "كلمة المرور غير صحيحة"
                               
                                
                                
                                
                            }
                         
                            
                        }

                    
                  })
        
        
        
    }//end of checkAccount function
    
    func checkPassword(){
        
        if((passwordTxt.text?.characters.count)! <= 5 && (passwordTxt.text?.characters.count)! != 0){
            passwordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text =  "كلمة المرور يجب أن تكون أكثر من ٥ حروف "
            self.passwordErrorFlag = true
            
        }
        else {
            clearPasswordErrorLabel()
            self.passwordErrorFlag = false
        }
           }//end of checkPassowrd function
 
    

    
    @IBAction func signInClicked(_ sender: Any) {
        
        if(checkIfAllAreEmpty() == true){
        return
        }
        
        if (checkIfOneIsEmpty() == true){
        return
            
        }
        
        
        checkPassword()
       
        checkEmailPattern()
        
        if (emailErrorFlag == true || passwordErrorFlag == true)
        {return
        }
        
               checkAccount()
        
    }//end of signInClicked function
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//end of didReceiveMemoryWarning function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        emptyFieldsErrorLabel.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignIn.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }//end of view did load
    func dismissKeyboard(){
        view.endEditing(true)
        
    }
    
    
}//end of class
