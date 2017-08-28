

import UIKit
import Firebase
import FirebaseDatabase

class signUpCustomer: UIViewController {
    
    @IBOutlet weak var confiremdPassErrorLabel: UILabel!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var signUpAsExpertBtn: UIButton!
    @IBOutlet weak var confiremedPassTxtField: UITextField!
    @IBOutlet weak var checkPhoneBtn: UIButton!
    @IBOutlet weak var passErrorLabel: UILabel!
    static var emailExistsBefore = true
    var badEmailFormatFlag = true
    var ref: DatabaseReference!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    var customerID = String()
    
    
    @IBAction func EmaileditingChangedActoin(_ sender: UITextField) {
        let email = self.emailTxtField.text
        Auth.auth().fetchProviders(forEmail: email!, completion: { (providers, error) in
            if providers == nil{
                signUpCustomer.emailExistsBefore = true
                if (signUpCustomer.emailExistsBefore == true && self.badEmailFormatFlag == true){
                    self.emailTxtField.backgroundColor = UIColor.white
                    self.emailErrorLabel.isHidden = true
                    
                }
                
            }
            else {
                self.emailErrorLabel.isHidden = false
                self.emailTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                self.emailErrorLabel.text = "البريد الإلكتروني موجود سابقاً"
                signUpCustomer.emailExistsBefore = false
                print("Auth.auth().fetchProviders")
                
            }
            
        })
        
    }
    
    @IBAction func EmaileditingDidEndActoin(_ sender: UITextField) {
        
        let email = self.emailTxtField.text
        Auth.auth().fetchProviders(forEmail: email!, completion: { (providers, error) in
            if providers == nil{
                signUpCustomer.emailExistsBefore = true
                if (signUpCustomer.emailExistsBefore == true && self.badEmailFormatFlag == true){
                    self.emailTxtField.backgroundColor = UIColor.white
                    self.emailErrorLabel.isHidden = true
                    
                }
                
            }
            else {
                self.emailErrorLabel.isHidden = false
                self.emailTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                self.emailErrorLabel.text = "البريد الإلكتروني موجود سابقاً"
                signUpCustomer.emailExistsBefore = false
                print("Auth.auth().fetchProviders")
                
            }
            
        })
        
    }
    
    //test
    func createCustomer(){
        // add new customer to Authentication sectoin in firebase
        let email = emailTxtField.text
        let password = passwordTxtField.text
        Auth.auth().createUser(withEmail: email!, password: password! , completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
            }
            else {
                self.customerID = (Auth.auth().currentUser?.uid)!
                print(self.customerID)
                //add all customer's informatoin to database sectoin
                self.addCustomerToDatabase()
            }
            
        })
    }
    
    func addCustomerToDatabase(){
        
        ref.child("Customers").child(customerID).child("name").setValue(nameTxtField.text)
        ref.child("Customers").child(customerID).child("email").setValue(emailTxtField.text)
        ref.child("Customers").child(customerID).child("phone").setValue(phoneTxtField.text)
        ref.child("Customers").child(customerID).child("phonePrivate").setValue(Utilities.isButtonClicked)
        
        Database.database().reference().child("Customers").queryOrderedByKey().queryEqual(toValue: customerID).observe(.value, with: { (DataSnapshot) in
            
            if(DataSnapshot.hasChild(self.customerID) && DataSnapshot.exists()){
                print("inside if")
                
                let customerRef = Database.database().reference().child("Customers/\(self.customerID)")
                customerRef.observe(.value , with: {
                    (snapshot) in
                    CustomerInformation.CustomerPassword = self.passwordTxtField.text

                    CustomerInformation.loadCustomerInfo(snapshot: snapshot,customerId: self.customerID)
                     self.performSegue(withIdentifier: "moveToCustomerHome", sender: self)
                }, withCancel: nil)
                

                
               
                
            }
            else{
                print("Not exist")
            }
        })
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let x = segue.destination as! CustomerHome
 
        
    }*/
    
    func checkEmail() -> Bool{
        
        let email = self.emailTxtField.text
        
        
        if(email?.isEmpty)!{
            self.emailTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            self.emailErrorLabel.isHidden = false
            self.emailErrorLabel.text = "الرجاء تعبئة هذا الحقل"
            return false
            
        }
        
        let emailValidateFlag = self.isValidEmailAddress(emailAddressString: email!) // call the function and store its return value
        
        if emailValidateFlag == false{
            self.emailTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            self.emailErrorLabel.isHidden = false
            self.emailErrorLabel.text = "الرجاء كتابة البريد الإلكتروني بالصيغة الصحيحة"
            self.badEmailFormatFlag = false
        }
        else{
            self.badEmailFormatFlag = true
        }
        
        if (signUpCustomer.emailExistsBefore == true && badEmailFormatFlag == true){
            self.emailTxtField.backgroundColor = UIColor.white
            self.emailErrorLabel.isHidden = true
            return true
        }
        else{
            return false
        }
        
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        
        //let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
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
    
    func validateName() -> Bool{
        var  numFoundFlag = true
        
        if (nameTxtField.text == ""){
            self.nameTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            nameErrorLabel.text = "الرجاء تعبئة هذا الحقل"
            nameErrorLabel.isHidden = false
            return false
        }
        
        // this line to extract all numbers (if exist) in name string
        let testName = nameTxtField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
       
       // test the name if it contains special characters
        var characterSet:NSCharacterSet = NSCharacterSet(charactersIn: "@!$%#^&*()?/.,\"[]{}':;|><=+\\±§،")
        
        if(testName != "" || self.nameTxtField.text?.rangeOfCharacter(from: characterSet as CharacterSet) != nil){
            numFoundFlag = false
            self.nameTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            nameErrorLabel.text = "الرجاء كتابة الإسم بشكل صحيح"
            nameErrorLabel.isHidden = false
        }
        else{
            numFoundFlag = true
            self.nameTxtField.backgroundColor = UIColor.white
            nameErrorLabel.isHidden = true
        }
        
        return numFoundFlag
    }// end of validateName() function

    
    // funcion to validate phone number
    func validatePhone() -> Bool{
        
        var errorFoundFlag = true
        var phoneErrorCounter = 0
        
        if (phoneTxtField.text == ""){
            phoneErrorCounter+=1
            self.phoneTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء تعبئة هذا الحقل"
            phoneErrorLabel.isHidden = false
            print("empty phone")
            return false
            
        }
        let testPhone = phoneTxtField.text?.components(separatedBy: CharacterSet.letters.inverted).joined(separator: "")
        
        if(testPhone != ""){
            phoneErrorCounter+=1
            self.phoneTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء كتابة رقم الجوال بشكل صحيح"
            phoneErrorLabel.isHidden = false
            return false
        }
        if (phoneTxtField.text?.characters.count != 10){
            phoneErrorCounter+=1
            self.phoneTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "رقم الجوال يجب أن يكون ١٠ خانات"
            phoneErrorLabel.isHidden = false
            
        }
        if (phoneTxtField.text?.hasPrefix("05") == false ){
            if(phoneTxtField.text?.hasPrefix("٠٥") == false){
                phoneErrorCounter+=1
                self.phoneTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                phoneErrorLabel.text = "رقم الجوال يجب أن يبدأ بـ 05"
                phoneErrorLabel.isHidden = false
            }
       
        }
        
        if (phoneErrorCounter == 0){
            print("No error found with phone")
            errorFoundFlag = true
            phoneErrorLabel.isHidden = true
            self.phoneTxtField.backgroundColor = UIColor.white
            
        }
        else{
            errorFoundFlag = false
        }
        
        return errorFoundFlag
        
    }
    
    
    func checkPassword() -> Bool{
        var passErrorCounter = 0
        
        if (passwordTxtField.text?.isEmpty)!{
            passErrorLabel.text = "الرجاء تعبئة هذا الحقل"
            passwordTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passErrorLabel.isHidden = false
            passErrorCounter+=1
            return false
            
        }
        if ((passwordTxtField.text?.characters.count)! <= 5)
        {
            passwordTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passErrorLabel.isHidden=false
            passErrorLabel.text="كلمة المرور يجب أن تكون أكثر من ٥ حروف"
            passErrorCounter+=1
        }
        
        if(passErrorCounter == 0){
            passErrorLabel.isHidden = true
            passwordTxtField.backgroundColor = UIColor.white
            return true
        }
        else{
            return false
        }
        
    }
    
    func checkConfirmedPassword() -> Bool{
        var confirmedErrorCounter = 0
        
        if(confiremedPassTxtField.text?.isEmpty)!{
            confiremedPassTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            confiremdPassErrorLabel.text = "الرجاء تعبئة هذا الحقل"
            confiremdPassErrorLabel.isHidden = false
            confirmedErrorCounter+=1
            return false
            
        }
        if (passwordTxtField.text?.isEqual(confiremedPassTxtField.text) == false){
            
            confiremedPassTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            confiremdPassErrorLabel.isHidden = false
            confiremdPassErrorLabel.text="كلمات السر المدخلة غير متطابقة"
            confirmedErrorCounter+=1
        }
        
        if(confirmedErrorCounter == 0){
            confiremedPassTxtField.backgroundColor = UIColor.white
            confiremdPassErrorLabel.isHidden = true
            
            return true
        }
        else{
            return false
        }
        
    }
    
    @IBAction func createAccountBtnActoin(_ sender: UIButton) {
        
        if( signUpCustomer.emailExistsBefore == true && checkEmail() && checkPassword() && checkConfirmedPassword() && validateName() && validatePhone()){
            createCustomer()
            
            
        }
        else{
            if(!checkEmail()){
                print("invalid email")
            }
            if(!checkPassword()){
                print("invalid password")
            }
            if(!checkConfirmedPassword())
            {
                print("invalid confiremd")
            }
            if(!validateName()){
                print("Invalid name")
            }
            if(!validatePhone()){
                print("invalid phone")
            }
        }
    }
    
    @IBAction func checkBoxPhone(_ sender: UIButton) {
          Utilities().checkBox(sender: sender)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            let NextView = segue.destination as! CustomerHome
            NextView.ViewAppearsAfterSignUp = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpAsExpertBtn.setTitleColor(UIColor.init(red: 161/255 , green: 143/255 , blue: 69/255, alpha: 1)
            , for: .normal)
        
        createAccountBtn.backgroundColor = colors.selectedColor
        emailErrorLabel.isHidden = true
        passErrorLabel.isHidden = true
        phoneErrorLabel.isHidden = true
        nameErrorLabel.isHidden = true
        confiremdPassErrorLabel.isHidden = true
        
        ref = Database.database().reference()
        
        Utilities.isButtonClicked = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
