//
//  orderStep2.swift
//  RuqiiSociety
//
//  Created by  on 9/5/17.
//  Copyright © 2017 abdllah aljohar. All rights reserved.
//

import UIKit


class orderStep2: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var fileLinkTxtField: UITextField!
    @IBOutlet weak var emptyFieldErrorLabel: UILabel!
    //@IBOutlet weak var chooseFileBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var step2NextBtn: UIButton!
    @IBOutlet weak var deliveryDateTxtField: UITextField!
    @IBOutlet weak var orderDiscriptionTxtView: UITextView!
    @IBOutlet weak var orderTitleTxtField: UITextField!
    @IBOutlet weak var fillOrderLabel: UILabel!
    // to represent the date in text field
    var dateFormatter : DateFormatter!
    
    static var OrderDiscription = String()
    static var OrderTitle = String()
    static var OrderDeliveryDate = String()
    static var attachedFileLink = String()
    
    // evert time user touch date text field, it shows date picker again
    @IBAction func touchDownDateTxtField(_ sender: UITextField) {
        self.datePicker.isHidden = false
    }
    /*
     @IBAction func chooseFileBtnActoin(_ senr: UIButton) {
     let fileUrl = Foundation.URL(string: "/Users/abdllahaljohar/Desktop")
     //let fileBrowserde = FileBrowser()
     let fileBrowser = FileBrowser(initialPath: fileUrl! )
     present(fileBrowser, animated: true, completion: nil)
     fileBrowser.didSelectFile = { (file: FBFile) -> Void in
     print(file.filePath)
     }
     
     
     }*/
    
    // date picker appear when user begin editing (touch) date text field
    @IBAction func beginEditingDeliveryDate(_ sender: UITextField) {
        if sender == self.deliveryDateTxtField{
            self.datePicker.isHidden = false
            
            //if you dont want the users to see the keyboard type:
            sender.endEditing(true)
        }
    }
    
    
    // every time user choose a date, it directly appears in the date text field
    @IBAction func valueChangedDatePicker(_ sender: UIDatePicker) {
        deliveryDateTxtField.text = dateFormatter.string(from: sender.date)
        
    }
    
    // next btn actoin
    @IBAction func orderStep2NextBtn(_ sender: UIButton) {
        if(fileLinkTxtField.text?.isEmpty == false){
            orderStep2.attachedFileLink = fileLinkTxtField.text!
            
        }
        if((deliveryDateTxtField.text?.isEmpty)! || (orderTitleTxtField.text?.isEmpty)! || orderDiscriptionTxtView.text.isEqual("الوصف")){
            
            emptyFieldErrorLabel.isHidden = false
            return
        }
        else{
            emptyFieldErrorLabel.isHidden = true
            self.performSegue(withIdentifier: "moveToOrderStep3", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.isHidden = true
        // set gray color to 'next' button
        fillOrderLabel.textColor = UIColor.init(red: 95/255 , green: 95/255 , blue: 95/255, alpha: 1)
        
        //text view placeholder text and color
        orderDiscriptionTxtView.text = "الوصف"
        orderDiscriptionTxtView.textColor = UIColor.lightGray
        
        // To enable placeholder and actoin events on text view which are not supported by default.
        orderDiscriptionTxtView.delegate = self
        
        // set text view border
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        orderDiscriptionTxtView.layer.borderColor = color
        orderDiscriptionTxtView.layer.borderWidth = 0.5
        orderDiscriptionTxtView.layer.cornerRadius = 5
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        // touch event to the whole view, to hide date picker after user choose a date.
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.hildDatePickerAfterChoosing (_:)))
        self.view.addGestureRecognizer(gesture)
        
        
        
        
    }
    // handle touch in view actoin
    func hildDatePickerAfterChoosing(_ sender:UITapGestureRecognizer){
        self.datePicker.isHidden = true
        
    }
    
    
    
    
    // the folowing two functions related to text view placeholder.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "الوصف"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
