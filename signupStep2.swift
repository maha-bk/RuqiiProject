

import UIKit
import Firebase
import FirebaseDatabase



class signupStep2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var IBANtxtField: UITextField!
    @IBOutlet weak var phoneNumTxtField: UITextField!
    @IBOutlet weak var dropdownList: UIPickerView!
    @IBOutlet weak var nextButtonStep2: UIButton!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var IBANerrorLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    
    var bankNames = ["البنك الأهلي التجاري", "مصرف الراجحي", "البنك الأول","مجموعة سامبا","بنك ساب","بنك البلاد","البنك السعودي الفرنسي",
                     "البنك العربي الوطني","بنك الجزيرة","بنك الرياض","مصرف إنماء","البنك السعودي للاستثمار","البنك السعودي الهولندي","أخرى"]
    
    
    
    var email = String ()
    var password = String ()
    
    //Touch up inside next button couse this code implementation
    @IBAction func moveToStep3(_ sender: Any) {
        if (validateName() && validatePhone() && validateIBAN () && bankTextField.text?.isEmpty == false){
            print("Move success")
            // implement the moving to "signupStep3" with id of segua (moveToStep3)
            self.performSegue(withIdentifier: "moveToStep3", sender: self)
        }
        if(!validateName()){
            print("Invalid name")
        }
        if(!validatePhone()){
            print("invalid phone")
        }
        if(!validateIBAN()){
            print("invalid IBAN")
        }
        if(bankTextField.text?.isEmpty)!{
            print("empty bank field")
            self.bankTextField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            bankLabel.text = "الرجاء تعبئة هذا الحقل"
            bankLabel.isHidden = false
        }
        else{
            self.bankTextField.backgroundColor = UIColor.white
            bankLabel.isHidden = true
            
        }
    }
    
    // function to pass data to another interface "signupStep3"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let step3Interface = segue.destination as! signupStep3
        step3Interface.expertEmail = email
        step3Interface.expertPassword = password
        step3Interface.expertName = fullNameTxtField.text!
        step3Interface.expertPhone = phoneNumTxtField.text!
        step3Interface.expertIBAN = IBANtxtField.text!
        step3Interface.expertBankName = bankTextField.text!
        
    }
    
    
    // function to check if name contains number or empty
    func validateName() -> Bool{
        var  numFoundFlag = true
        
        if (fullNameTxtField.text == ""){
            self.fullNameTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            nameErrorLabel.text = "الرجاء تعبئة هذا الحقل"
            nameErrorLabel.isHidden = false
            return false
        }
        
        // this line to extract all numbers (if exist) in name string
        let testName = fullNameTxtField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if(testName != ""){
            numFoundFlag = false
            self.fullNameTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            nameErrorLabel.text = "الرجاء كتابة الإسم بشكل صحيح"
            nameErrorLabel.isHidden = false
        }
        else{
            numFoundFlag = true
            self.fullNameTxtField.backgroundColor = UIColor.white
            nameErrorLabel.isHidden = true
        }
        
        return numFoundFlag
    }// end of validateName() function
    
    
    // funcion to validate phone number
    func validatePhone() -> Bool{
        
        var errorFoundFlag = true
        var phoneErrorCounter = 0
        
        if (phoneNumTxtField.text == ""){
            phoneErrorCounter+=1
            self.phoneNumTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء تعبئة هذا الحقل"
            phoneErrorLabel.isHidden = false
            print("empty phone")
            return false
            
        }
        let testPhone = phoneNumTxtField.text?.components(separatedBy: CharacterSet.letters.inverted).joined(separator: "")
        
        if(testPhone != ""){
            phoneErrorCounter+=1
            self.phoneNumTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "الرجاء كتابة رقم الجوال بشكل صحيح"
            phoneErrorLabel.isHidden = false
            return false
        }
        if (phoneNumTxtField.text?.characters.count != 10){
            phoneErrorCounter+=1
            self.phoneNumTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "رقم الجوال يجب أن يكون ١٠ خانات"
            phoneErrorLabel.isHidden = false
            
        }
        if (phoneNumTxtField.text?.hasPrefix("05")) == false{
            phoneErrorCounter+=1
            self.phoneNumTxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            phoneErrorLabel.text = "رقم الجوال يجب أن يبدأ بـ 05"
            phoneErrorLabel.isHidden = false
        }
        
        if (phoneErrorCounter == 0){
            print("No error found with phone")
            errorFoundFlag = true
            phoneErrorLabel.isHidden = true
            self.phoneNumTxtField.backgroundColor = UIColor.white
            
        }
        else{
            errorFoundFlag = false
        }
        
        return errorFoundFlag
        
    }
    
    
    func validateIBAN () -> Bool{
        var ibanErrorsCounter = 0
        var errorFoundFlag = true
        
        if (IBANtxtField.text == ""){
            ibanErrorsCounter+=1
            self.IBANtxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            IBANerrorLabel.text = "الرجاء تعبئة هذا الحقل"
            IBANerrorLabel.isHidden = false
            print("empty iban")
            return false
            
        }
        if (IBANtxtField.text?.hasPrefix("SA") == false){
            ibanErrorsCounter+=1
            self.IBANtxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            IBANerrorLabel.text = "رقم الآيبان يجب أن يبدأ بـ SA"
            IBANerrorLabel.isHidden = false
            return false
        }
        
        if (IBANtxtField.text?.characters.count != 24){
            ibanErrorsCounter+=1
            self.IBANtxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            IBANerrorLabel.text = "رقم الآيبان يجب أن يكون ٢٤ خانة"
            IBANerrorLabel.isHidden = false
        }
        
        let testIBAN = IBANtxtField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        if (testIBAN?.characters.count != 22){
            ibanErrorsCounter+=1
            self.IBANtxtField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            IBANerrorLabel.text = "رقم الأيبان يجب أن يحتوي على ٢٢ رقما"
            IBANerrorLabel.isHidden = false
            
        }
        
        if (ibanErrorsCounter == 0){
            print("No error found with IBAN")
            errorFoundFlag = true
            IBANerrorLabel.isHidden = true
            self.IBANtxtField.backgroundColor = UIColor.white
            
        }
        else{
            errorFoundFlag = false
        }
        
        return errorFoundFlag
        
        
    }
    
    // the following 5 function below all related to picker view (bank names list )
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)-> Int{
        
        return bankNames.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return bankNames[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.bankTextField.text = self.bankNames[row]
        self.dropdownList.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if textField == self.bankTextField{
            self.dropdownList.isHidden = false
            
            //if you dont want the users to see the keyboard type:
            textField.endEditing(true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(email)
        print(password)
        nameErrorLabel.isHidden = true
        phoneErrorLabel.isHidden = true
        IBANerrorLabel.isHidden = true
        bankLabel.isHidden = true
        dropdownList.isHidden = true
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
}
