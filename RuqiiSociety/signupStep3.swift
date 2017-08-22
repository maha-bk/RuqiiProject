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
    static let selectedColor = UIColor.init(red: 20/255 , green: 15/255 , blue: 63/255, alpha: 1)
    static let wightColor = UIColor.white
}

class signupStep3: UIViewController {
    @IBOutlet weak var startButtin: UIButton!

    
    var ButtonsArray = [UIButton]()
    
    // to hold services names from database
    var servicesName = [String] ()
    var expertName = String ()
    var expertPhone = String ()
    var expertIBAN = String ()
    var expertBankName = String ()
    var expertEmail = String ()
    var expertPassword = String ()
    var expertAllowPhone = Bool()
    var isButtonClicked = Bool()
    var btnNumber = Int()
    var selectedInterests = [String] ()
    var expertTitle = ["writer" : "", "photo" : "", "designer" : "", "programmer" : ""]
    var userID = String ()
    var flag = Bool ()
    
    
    

    @IBOutlet weak var interestErrorLabel: UILabel!
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
    var ref: DatabaseReference! // to hold our database refernce
    
    // handle the return value in firebase functions to be able to delete the observer later in deinit
    var databaseHandle : DatabaseHandle!
    
    @IBAction func selectInterest(_ sender: UIButton) {
         ButtonsArray.removeAll()
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

        
    
    
    
    // get services from database and represent it in text fields
    func getServices() {
        ref = Database.database().reference()
        
        databaseHandle = self.ref.child("Services").observe(.childAdded, with: {(snapshot) -> Void in
       
            let service = snapshot.childSnapshot(forPath: "Name").value as? String
            if let actualSrevice = service {
               self.servicesName.append(actualSrevice)
            }
            for i in 0..<self.servicesName.count
            {
                self.ButtonsArray[i].setTitle(self.servicesName[i], for: .normal)
            }
            
        })
        
       
    }
    
    //to remove the observer
    deinit {
        self.ref.child("Services").removeObserver(withHandle: databaseHandle)
    }

   
  
    // filling the array of text fields
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
   
    

    @IBAction func startbuttonAction(_ sender: Any) {
        
        selectedInterests.removeAll()
        for var i in 0..<ButtonsArray.count{
            if(ButtonsArray[i].currentBackgroundImage == #imageLiteral(resourceName: "darkBlue")){
                selectedInterests.append(ButtonsArray[i].currentTitle!)
                interestErrorLabel.isHidden = true
               
            }
        }
        if(selectedInterests.count == 0){
            interestErrorLabel.text = "يجب إختيار إهتمام واحد على الأقل"
            interestErrorLabel.isHidden = false
             return
        }
 
        createUser()
       

       
        
       
        /*for (key , value) in expertTitle{
            print(value)
            
        }
        expertTitle = ["writer" : "", "photo" : "", "designer" : "", "programmer" : ""]
        */
        }
    
   
    
    func checkCategory (){
      
        for var i in 0..<selectedInterests.count{
            databaseHandle = self.ref.child("Services").observe(.childAdded, with: {(snapshot) -> Void in
                
                let service = snapshot.childSnapshot(forPath: "Name").value as? String
                if let actualSrevice = service {
                    if (actualSrevice.contains(self.selectedInterests[i])){
                        let catog = snapshot.childSnapshot(forPath: "Category").value as? String
                        //unwrapping
                        if let category = catog{
                            switch(category){
                            case "Category4":
                                self.expertTitle["programmer"] =  "مبرمجة"
                                print("Mahaaaa")
                            case "Category2":
                                self.expertTitle["designer"] = "مصممة"
                            case "Category3":
                                self.expertTitle["photo"] = "مصورة"
                            case "Category1":
                                self.expertTitle["writer"] = "أديبة"
                            default:
                                print("No title")
                                
                            }
                        }
                    }
                }
               
               
            })
          
            
        }
      
      
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let expertHome = segue.destination as! ExpertHome
   
        
    }
    
    func createUser(){
        Auth.auth().createUser(withEmail: expertEmail, password: expertPassword, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.userID = (Auth.auth().currentUser?.uid)!
                print("Lobnaaaa")
                self.createNewExpert()
                self.checkCategory()
                self.performSegue(withIdentifier: "moveToHome", sender: self)


                
            }
            
        })
    }
    
    func createNewExpert(){
      ref.child("Experts").childByAutoId().setValue(userID)
        print("New Expert")
       
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButtin.backgroundColor = colors.selectedColor
        self.fillArrayOfButtons()
        self.getServices()
        isButtonClicked = false
        interestErrorLabel.isHidden = true
        
        /*for var i in 0..<ButtonsArray.count{
            btnNumber = i
            ButtonsArray[i].addTarget(self, action: #selector(selectInterst), for: .t)
            
        }*/
      

    }
    

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
