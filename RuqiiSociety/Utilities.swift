//
//  Utilities.swift
//  RuqiiSociety
//
//  Created by abdllah aljohar on 31/07/2017.
//  Copyright © 2017 abdllah aljohar. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static var isButtonClicked = Bool ()
    var checkbox = UIImage(named: "checked")
    var uncheckbox = UIImage(named: "unchecked")
    
    /*static var checkbox = UIImage(named: "checked")
    static var uncheckbox = UIImage(named: "unchecked")
    static var isButtonClicked = Bool()
    
     static func clickedCheckbox() {
       
        
        if (Utilities.isButtonClicked == true){
            Utilities.isButtonClicked = false
        }
        else{
           Utilities.isButtonClicked  = true
        }
        
        if (Utilities.isButtonClicked == true){
            checkboxButton.setImage(Utilities.checkbox, for: UIControlState.normal)
        }
        else{
            checkboxButton.setImage(Utilities.uncheckbox, for: UIControlState.normal )
        }
    }*/

    // function to show an Error alert to user by pop up
    // Note: UIAlertController is considered as UIViewController as well.
    func ShowAlert (title: String, msg: String, vc: UIViewController){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        // this function will add a button to the popup 
        // when there is No Action after user clicks "حسنا" button, handler is nil
        alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    func checkBox (sender: UIButton){
        if (Utilities.isButtonClicked == true){
            Utilities.isButtonClicked = false
        }
        else{
            Utilities.isButtonClicked = true
        }
        
        if (Utilities.isButtonClicked == true){
           sender.setImage(checkbox, for: UIControlState.normal)
        }
        else{
            sender.setImage(uncheckbox, for: UIControlState.normal )
        }

    }
    
    /*func KeyboaredNotification(view: UIViewController){
        NotificationCenter.default.addObserver(view, selector: #selector(keyboardWillShow(_:, vi )), name: NSNotification.Name.UIKeyboardWillShow, object: view.view.window)
        
        NotificationCenter.default.addObserver(view, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: view.view.window)
    }
    
    func keyboardWillShow(_ sender: NSNotification, myview: UIViewController) {
        let userInfo: [NSObject:AnyObject] = sender.userInfo! as [NSObject : AnyObject]
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.cgRectValue().size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.cgRectValue().size
        
        if keyboardSize.height == offset.height {
            if myview.view.frame.origin.y == 0 {
                UIView.animate(withDuration: 0.15, animations: {
                    myview.view.frame.origin.y -= keyboardSize.height
                })
            }
        }
        else {
            UIView.animate(withDuration: 0.15, animations: {
                myview.view.frame.origin.y+=keyboardSize.height - offset.height
            })
        }
    }*/
    

    
   

}
