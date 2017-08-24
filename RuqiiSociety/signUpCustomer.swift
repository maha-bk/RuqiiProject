//
//  signUpCustomer.swift
//  RuqiiSociety
//
//  Created by abdllah aljohar on 24/08/2017.
//  Copyright © 2017 abdllah aljohar. All rights reserved.
//

import UIKit

class signUpCustomer: UIViewController {

    @IBOutlet weak var confiremdPassErrorLabel: UILabel!
    @IBOutlet weak var confiremedPassTxtField: DesignableTextField!
  
    @IBOutlet weak var passErrorLabel: DesignableTextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var emailTxtField: DesignableTextField!
    @IBOutlet weak var confirmedPassTxtField: DesignableTextField!
    @IBOutlet weak var passwordTxtField: DesignableTextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var signUpAsExpertBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpAsExpertBtn.setTitleColor(UIColor.init(red: 161/255 , green: 143/255 , blue: 69/255, alpha: 1)
        , for: .normal)
        
        createAccountBtn.backgroundColor = colors.selectedColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
