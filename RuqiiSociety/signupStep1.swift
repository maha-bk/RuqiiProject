
import UIKit
import Firebase
import FirebaseDatabase

class signupStep1: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var nextButtonStep1: UIButton!
    @IBOutlet weak var emptyFieldsErrorLabel: UILabel!
    @IBOutlet weak var confirmedErrorLabel: UILabel!
    @IBOutlet weak var passErrorLabel: UILabel!
    
    
    
    var badEmailFormatFlag = true
    static var emailExistsBefore = true
    
    
    
    // email text field event to check that if email exists before in database or not "it checks after first time editing"
    @IBAction func editingDidEndEmail(_ sender: UITextField) {
        let email = self.emailTxtField.text
        Auth.auth().fetchProviders(forEmail: email!, completion: { (providers, error) in
            if providers == nil{
                signupStep1.emailExistsBefore = true
                if (signupStep1.emailExistsBefore == true && self.badEmailFormatFlag == true){
                    self.emailTxtField.backgroundColor = UIColor.white
                    self.emailErrorLabel.isHidden = true
                    
                }
                
            }
            else {
                self.emailErrorLabel.isHidden = false
                self.emailTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                self.emailErrorLabel.text = "البريد الإلكتروني موجود سابقاً"
                signupStep1.emailExistsBefore = false
                print("Auth.auth().fetchProviders")
                
            }
            
        })
        
    }
    
    // email text field event to check that if email exists before in database or not "it checks after editing for second time"
    @IBAction func editingChangedEmail(_ sender: UITextField) {
        let email = self.emailTxtField.text
        Auth.auth().fetchProviders(forEmail: email!, completion: { (providers, error) in
            if providers == nil{
                signupStep1.emailExistsBefore = true
                if (signupStep1.emailExistsBefore == true && self.badEmailFormatFlag == true){
                    self.emailTxtField.backgroundColor = UIColor.white
                    self.emailErrorLabel.isHidden = true
                    
                }
                
            }
            else {
                self.emailErrorLabel.isHidden = false
                self.emailTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
                self.emailErrorLabel.text = "البريد الإلكتروني موجود سابقاً"
                signupStep1.emailExistsBefore = false
                print("Auth.auth().fetchProviders")
                
            }
            
        })
        
    }
    
    @IBAction func moveToStep2Action(_ sender: UIButton) {
        if (checkInput() == false || signupStep1.emailExistsBefore == false) {
            return
        }
        else
        {
            // implement the moving to "signupStep2" with id of segua (moveToStep2)
            self.performSegue(withIdentifier: "moveToStep2", sender: self)
            ExpertInformation.ExpertPassword = self.passTxtField.text
        }
    }
    
    // function to pass data to another interface "signupStep2"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let step2Interface = segue.destination as! signupStep2
        step2Interface.email = emailTxtField.text!
        step2Interface.password = passTxtField.text!
        
    }
    
    
    
    
    
    
    //this function call isValidEmailAddress function to ckeck email format
    func checkEmail(){
        
        let email = self.emailTxtField.text
        
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
        
        if (signupStep1.emailExistsBefore == true && badEmailFormatFlag == true){
            self.emailTxtField.backgroundColor = UIColor.white
            self.emailErrorLabel.isHidden = true
            
            
        }
        
    }
    
    
    
    
    
    //check if entered email is in correct format or not
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
    
    
    
    // function foe check all entered inputs
    func checkInput() -> Bool{
        
        var errorsCounter = 0
        
        //check if fields are empty
        
        if (emailTxtField.text?.isEmpty)!  && (passTxtField.text?.isEmpty)! && (confirmPassField.text?.isEmpty)!{
            emptyFieldsErrorLabel.isHidden = false
            emptyFieldsErrorLabel.text = "الرجاء تعبئة جميع الحقول"
            errorsCounter += 1
            return false
            
        }
        else if (emailTxtField.text?.isEmpty)! || (passTxtField.text?.isEmpty)! || (confirmPassField.text?.isEmpty)!{
            emptyFieldsErrorLabel.isHidden = false
            emptyFieldsErrorLabel.text = "الرجاء تعبئة جميع الحقول"
            errorsCounter += 1
            
        }
        else{
            emptyFieldsErrorLabel.isHidden=true
        }
        
        
        
        //check if password less than 5 charecters
        if ((passTxtField.text?.characters.count)! <= 5)
        {
            passTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            passErrorLabel.isHidden=false
            passErrorLabel.text="كلمة المرور يجب أن تكون أكثر من ٥ حروف"
            errorsCounter+=1
        }
            
        else {
            
            passTxtField.backgroundColor = UIColor.white
            passErrorLabel.isHidden = true
        }
        
        // check if first and second passwords are identical or not
        if  (passTxtField.text?.isEqual(confirmPassField.text))!{
            confirmPassField.backgroundColor = UIColor.white
            confirmedErrorLabel.isHidden = true
            
        }
        else{
            confirmPassField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            confirmedErrorLabel.isHidden = false
            confirmedErrorLabel.text="كلمات السر المدخلة غير متطابقة"
            errorsCounter+=1
        }
        // call for check email function
        checkEmail()
        
        
        if (errorsCounter > 0 || signupStep1.emailExistsBefore == false || badEmailFormatFlag == false){
            return false
        }
        else{
            return true
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailErrorLabel.isHidden = true
        passErrorLabel.isHidden = true
        confirmedErrorLabel.isHidden = true
        emptyFieldsErrorLabel.isHidden = true
        nextButtonStep1.backgroundColor = colors.selectedColor
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

