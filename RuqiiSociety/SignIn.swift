/// SignIn.swift
//  RuqiiSociety
//  Created by Maha alkatheiry on 24/07/2017.
//  Copyright © 2017 Maha alkatheiry. All rights reserved.


import UIKit
import Firebase
import FirebaseDatabase

class SignIn: UIViewController {
    
    // Declaring the components of the view or interface
    
   
    
    @IBOutlet weak var passwordTxt: DesignableTextField!
    @IBOutlet weak var loadingLabel: UIActivityIndicatorView!
    @IBOutlet weak var emptyFieldsErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var forgetPasswordBtn: UIButton!
  
    // Declaring & initializing flag variables to be used whithin the class
    
    var emailErrorFlag = false
    var passwordErrorFlag = false
   
    var UserType = ""
    var UserId = ""
    var ExpertProfileDictionary = [String: AnyObject]()
    var CustomerProfileDictionary = [String: AnyObject]()
    // Clear the text in labels only without resetting the color of the text fields

    func clearLabelsWithflushing(){
        self.emailErrorLabel.isHidden = true
        self.emailErrorLabel.text =  " "
        self.passwordErrorLabel.isHidden = true
        self.passwordErrorLabel.text =  " "
        
    }// end of clearLabelsWithflushing function
    
    // hi maha bader
    // Clear the email label and text field if there is no error
    
    func clearEmailErrorLabel(){
        emailTxt.backgroundColor = UIColor.white
        emailErrorLabel.isHidden = true
        emailErrorLabel.text =  " "
        
        
    }// end of clearEmailErrorLabel function
    
    
    // Clear the password label and text field if there is no error
    
    func clearPasswordErrorLabel(){
        passwordTxt.backgroundColor = UIColor.white
        passwordErrorLabel.isHidden = true
        passwordErrorLabel.text =  " "
        
    }// end of clearPasswordErrorLabel function
    
    
    // Passing some data from the current interface to the next one right before performing a segue command (moving to another interface)
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (UserType == "Expert"){
        let NextView = segue.destination as! ExpertHome
        NextView.ViewAppearsAfterLogin = true
        
     
          }
    else if (UserType == "Customer"){
    
        let NextView = segue.destination as! tabbedBarSetting
        NextView.ViewAppearsAfterLogin = true
       
        
    }
    
    }// end of prepare function 
    
  
    // Checking if both email and password text fields were empty
    
    func checkIfAllAreEmpty() -> Bool{
        if ((emailTxt.text?.isEmpty)! && (passwordTxt.text?.isEmpty)!)
        {
            emailTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passwordTxt.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            emptyFieldsErrorLabel.isHidden = false
            emptyFieldsErrorLabel.text = "الرجاء تعبئة جميع الحقول"
            clearLabelsWithflushing()
            
            return true
        }
        else {
            emptyFieldsErrorLabel.isHidden = true
            emptyFieldsErrorLabel.text = ""
            clearEmailErrorLabel()
            clearPasswordErrorLabel()
            
            return false
        }

    
    }// end of checkIfAllAreEmpty function
    
    
    //Checking if one field either email or password is empty
    
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
            
            
        }

    return returnValue
        
    }// end of checkIfOneIsEmpty function
    
    
    // Checking if the email was correctly formatted
    
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
    }// end of checkEmailPattern function

    
    // Comparing the passed email address with the valid email pattern (regular expresion)
    
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
    
    }//end of isValidEmailAddress function

    
    /* After checking email and password are well formatted, check if
     the account exists or if the email exists but the user has typed in the wrong password*/
    
    func checkAccount() {
        
        let email = emailTxt.text
        let password = passwordTxt.text
                Auth.auth().signIn(withEmail: email!, password: password!, completion: {(user, error) in
                    // Redirecting the user to the Home interface based on his/her role (Expert or Customer)
                    
                    if(user != nil){
                          self.loadingLabel.isHidden = false
                       self.distinguishUserType()
                                                        }
                    
                   // Showing proper error message if the user does not exist
                    
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
        
        
        
    }// end of checkAccount function
    
    
    // Checking if the password contains more than 5 characters
    
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

    
    // Knowing the user type and based on it the user will be redirected to the proper home interface
    
    func distinguishUserType() {
    
        UserId = (Auth.auth().currentUser?.uid)!
      
        
       Database.database().reference().child("Experts").queryOrderedByKey().queryEqual(toValue: UserId).observe(.value, with: { (DataSnapshot) in
       
        if(DataSnapshot.hasChild(self.UserId) && DataSnapshot.exists()){
            ExpertInformation.ExpertPassword = self.passwordTxt.text
            self.UserType = "Expert"
            let expertRef = Database.database().reference().child("Experts/\(self.UserId)")
            expertRef.observe(.value , with: {
                (snapshot) in
                ExpertInformation.loadExpertInfo(snapshot: snapshot,expertId: self.UserId)
                
            }, withCancel: nil)
            self.performSegue(withIdentifier: "ExpertHome", sender: self)}
        
        
        }, withCancel:
        {(error) in
        print(error.localizedDescription)
        })
        
        Database.database().reference().child("Customers").queryOrderedByKey().queryEqual(toValue: UserId).observe(.value, with: { (DataSnapshot) in
            if(DataSnapshot.hasChild(self.UserId) && DataSnapshot.exists()){
                CustomerInformation.CustomerPassword = self.passwordTxt.text
               
                self.UserType = "Customer"
                let customerRef = Database.database().reference().child("Customers/\(self.UserId)")
                customerRef.observe(.value , with: {
                    (snapshot) in
                    CustomerInformation.loadCustomerInfo(snapshot: snapshot,customerId: self.UserId)
                    
                }, withCancel: nil)
                self.performSegue(withIdentifier: "CustomerHome", sender: self)}
           
            
        }, withCancel:
            {(error) in
                print(error.localizedDescription)
        })
 
        
    }// end of distinguishUserType function
    

    // Checking if all inputs are correct when signInBtn is pressed .Then, log the user to his/her account
    
    
  
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
       

       
    }// end of signInClicked action
    
    
    // Restting the password after successful email validation
    
    func resetPassword(){
     let email = emailTxt.text
        
        Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
            
            if (error != nil) {
                Utilities().ShowAlert(title: "خطأ", msg:"عذرا حدث خطأ .الرجاء المحاولة مرة أخرى.", vc: self, NextView: "")
                return
            }
            else {
                Utilities().ShowAlert(title: "تمت العملية بنجاح", msg: " تم إرسال رابط تغيير كلمة المرور إلي بريدك الإلكتروني", vc: self, NextView: "")
            }
        }

    
    }// end of resetPassword function
    
    
    // Validating the email address when forgetPasswordBtn is clicked before reseting the user's password
    
    @IBAction func forgetPasswordClicked(_ sender: UIButton) {
        
        let email = emailTxt.text
        
        // Checking if the email is empty
        
        if (email?.isEmpty)!{
        Utilities().ShowAlert(title: "خطأ", msg: "الرجاء تعبئة البريد الإلكتروني" , vc: self, NextView: "")
        return
        }
        
        // Checking if the email is correctly formatted
        
        let flag = isValidEmailAddress(emailAddressString: email!)
        if (flag == false) {
          Utilities().ShowAlert(title: "خطأ", msg: "الرجاء كتابة البريد الالكتروني بصيغة صحيحة" , vc: self, NextView: "")
        return
        }
        
        // Checking if the email belongs to a registered user or not
        
        Auth.auth().fetchProviders(forEmail: email!, completion: { (providers, error) in
            
            // The email does not exist in the database
            
            if providers == nil{
                Utilities().ShowAlert(title: "خطأ", msg: "البريد الالكتروني غير مسجل لدينا. الرجاء المحاولة مجددا." , vc: self, NextView: "")
            }
             // The email exists in the database
            else {
              self.resetPassword()
  
            }
            
        })
        
    }// end of forgetPasswordClicked action
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }// end of didReceiveMemoryWarning function
    
    
    /* When the view or interface is loaded for the first time clear all the error labels and create an object of type
    UITapGestureRecognizer to dismiss the keyboard when it is not in use*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        emptyFieldsErrorLabel.isHidden = true
        loadingLabel.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignIn.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }// end of viewDidLoad function
    
    // Not showing the keyboard after editing is finished
    
    func dismissKeyboard(){
        view.endEditing(true)
        
    }// end of dismissKeyboard function
    
    
}//end of class
