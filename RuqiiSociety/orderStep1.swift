//
//  orderStep1.swift
//  RuqiiSociety
//
//  Created by  on 9/5/17.
//  Copyright © 2017 abdllah aljohar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class orderStep1: UIViewController {

    @IBOutlet weak var loadDataLabel: UILabel!
    @IBOutlet weak var InterestErrorLabel: UILabel!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var orderNextBtn: UIButton!
    
    var servicesName = [String] ()
    var ButtonsArray = [UIButton]()
    var ref: DatabaseReference!
    var databaseHandle : DatabaseHandle!

    
    @IBAction func selectInterestActoin(_ sender: UIButton) {
        
        ButtonsArray.removeAll()
        // to know if button selected or not
        if(sender.currentBackgroundImage == #imageLiteral(resourceName: "darkBlue")){
            sender.setBackgroundImage(#imageLiteral(resourceName: "border"), for: UIControlState.normal )
            sender.setTitleColor(UIColor.black, for: .normal)
        }
        else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "darkBlue"), for: UIControlState.normal)
            sender.setTitleColor(colors.wightColor, for: .normal)
            
        }
        fillArrayOfButtons()
        
    }
    
    
    // filling the array of buttons
    func fillArrayOfButtons(){
        ButtonsArray.append(btn1)
        ButtonsArray.append(btn2)
        ButtonsArray.append(btn3)
        ButtonsArray.append(btn4)
        ButtonsArray.append(btn5)
        ButtonsArray.append(btn6)
        ButtonsArray.append(btn7)
        ButtonsArray.append(btn8)
        ButtonsArray.append(btn9)
        ButtonsArray.append(btn10)
        ButtonsArray.append(btn11)
        ButtonsArray.append(btn12)
        
    }
    
    // get services from database and represent it in buttons
    func getServices() {
        
        ref = Database.database().reference()
        print(ref)
        
        databaseHandle = self.ref.child("Services").observe(.childAdded, with: {(snapshot) -> Void in
            
            let service = snapshot.childSnapshot(forPath: "Name").value as? String
            
            if let actualSrevice = service {
                self.servicesName.append(actualSrevice)
            }
            for i in 0..<self.servicesName.count
            {
                //(top: 10, left: 10, bottom: 10, right: 10)
                self.ButtonsArray[i].imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6)
                
                self.ButtonsArray[i].setTitle("   " + self.servicesName[i], for: .normal)
                if (i == self.ButtonsArray.count - 1){
                    self.loadDataLabel.isHidden = true
                }
            }
            
            
        })
        
        
    }
    
    //to remove the observer for reading services
    deinit {
        self.ref.child("Services").removeObserver(withHandle: databaseHandle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillArrayOfButtons()
        getServices()
        InterestErrorLabel.isHidden = true
        
      

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
