//
//  ViewController44.swift
//  RuqiiSociety
//
//  Created by abdllah aljohar on 23/07/2017.
//  Copyright © 2017 abdllah aljohar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct colors {
    static let selectedColor = UIColor.init(red: 20 , green: 15 , blue: 63, alpha: 1)
    static let wightColor = UIColor.white
}

class signupStep3: UIViewController {
    @IBOutlet weak var startButtin: UIButton!
    var expertName = String ()
    var expertPhone = String ()
    var expertIBAN = String ()
    var expertBankName = String ()
    var expertEmail = String ()
    var expertPassword = String ()
    var expertAllowPhone = Bool()
    var ref: DatabaseReference!
    
    // handle the return value if firebase functions
    var databaseHandle : DatabaseHandle!
    
    //var txtfieds =  [UIButton] ()
    @IBOutlet weak var txtfield1: DesignableTextField!
    @IBOutlet weak var txtfield8: DesignableTextField!
    @IBOutlet weak var txtfield12: DesignableTextField!
    @IBOutlet weak var txtfield11: DesignableTextField!
    @IBOutlet weak var txtfield10: DesignableTextField!
    @IBOutlet weak var txtfield9: DesignableTextField!
    @IBOutlet weak var txtfield7: DesignableTextField!
    @IBOutlet weak var txtfield6: DesignableTextField!
    @IBOutlet weak var txtfield5: DesignableTextField!
    @IBOutlet weak var txtfield4: DesignableTextField!
    @IBOutlet weak var txtfield3: DesignableTextField!
    @IBOutlet weak var txtfield2: DesignableTextField!
    
    var txtfieldsArray = [UITextField]()
    var servicesName = [String] ()
    
    func fillArrayOfTxtFields(){
         txtfieldsArray.append(txtfield1)
         txtfieldsArray.append(txtfield2)
         txtfieldsArray.append(txtfield3)
         txtfieldsArray.append(txtfield4)
         txtfieldsArray.append(txtfield5)
         txtfieldsArray.append(txtfield6)
         txtfieldsArray.append(txtfield7)
         txtfieldsArray.append(txtfield8)
         txtfieldsArray.append(txtfield9)
         txtfieldsArray.append(txtfield10)
         txtfieldsArray.append(txtfield11)
         txtfieldsArray.append(txtfield12)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        databaseHandle = ref.child("Services").observe(.childChanged, with: { (snapshot) in
            let service = snapshot.children.value(forKey: "Name") as? String
            
            if let actualSrevice = service {
                self.servicesName.append(actualSrevice)
                
            }
        })
        
            for var i in 0..<self.servicesName.count
            {
                self.txtfieldsArray[i].text = self.servicesName[i]
            }
        /*
        let stackView1 = UIStackView(arrangedSubviews: createTxtFields(named: "1", "2","3"))
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.axis = .vertical
        stackView1.spacing = 24
        stackView1.distribution = .fillEqually
        
        view.addSubview(stackView1)*/
        
        // constriants
        
        
      
        
     
        /*
        let textFiled = UIButton(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        textFiled.backgroundColor = UIColor.red
        
        
        let textFiled2 = UIButton(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        textFiled2.backgroundColor = UIColor.red
       
        
        txtfieds.append(textFiled)
        txtfieds.append(textFiled2)
        
        let stackView = UIStackView(arrangedSubviews: txtfieds)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
              view.addSubview(stackView)*/
        
        
        // Do any additional setup after loading the view.
    }
    // create array of text fields
   
    /*
    func createTxtFields(named: String...) -> [UITextField]{
        //map allow us to iterate through a secuence and a apply what ever we want to each element and return an array
     return named.map { name in
            
            let txtfield = UITextField()
            txtfield.translatesAutoresizingMaskIntoConstraints = false
            txtfield.text = name
            txtfield.backgroundColor = colors.wightColor
            
            return txtfield
        }
    }*/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
