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
import FirebaseAuth


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
    
    @IBOutlet weak var dataConnectLabel: UILabel!
    @IBOutlet weak var dataLoadLabel: UILabel!
    // handle the return value in firebase functions to be able to delete the observer later in deinit
    var databaseHandle : DatabaseHandle!
    
    @IBAction func selectInterest(_ sender: UIButton) {
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

        
    
    
    
    // get services from database and represent it in buttons
    func getServices() {
       
        ref = Database.database().reference()
        print(ref)
        
        databaseHandle = self.ref.child("Services").observe(.childAdded, with: {(snapshot) -> Void in
       
            let service = snapshot.childSnapshot(forPath: "Name").value as? String
            print(service!)
            /*if let actualSrevice = service {
               self.servicesName.append(actualSrevice)
            }*/
            for i in 0..<self.servicesName.count
            {
                self.ButtonsArray[i].setTitle(self.servicesName[i], for: .normal)
                if (i == self.ButtonsArray.count - 1){
                    self.dataConnectLabel.isHidden = true
                }
            }
            
            
        })
        
       
    }
    
    //to remove the observer for reading services
    deinit {
        self.ref.child("Services").removeObserver(withHandle: databaseHandle)
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
   

    @IBAction func startbuttonAction(_ sender: Any) {
        
        selectedInterests.removeAll()
        
        //to know the selected interests
        for var i in 0..<ButtonsArray.count{
            if(ButtonsArray[i].currentBackgroundImage == #imageLiteral(resourceName: "darkBlue")){
                selectedInterests.append(ButtonsArray[i].currentTitle!)
                interestErrorLabel.isHidden = true
                dataLoadLabel.isHidden = false
               
            }
        }
        //No interests selected, error will appear
        if(selectedInterests.count == 0){
            interestErrorLabel.text = "يجب إختيار إهتمام واحد على الأقل"
            interestErrorLabel.isHidden = false
             return
        }
        // if everything is okey, start registeration process
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
                                
                            }// end switch
                         
                        }// end catog if
                    }// end contains if
                }//end actualSrevice if
             
            })// end observe

       }//end for loop

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       segue.destination as! ExpertHome
   
        
    }
    
    
    
    func createUser(){
        
        Auth.auth().createUser(withEmail: expertEmail, password: expertPassword, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            
            }
            else {
                self.userID = (Auth.auth().currentUser?.uid)!
                print( self.userID )
                self.createNewExpert()
                
                
                
                
            }
            
        })
    }
    

    func createNewExpert(){
        
      ref.child("Experts").child(userID).child("name").setValue(expertName)
      ref.child("Experts").child(userID).child("phone").setValue(expertPhone)
      ref.child("Experts").child(userID).child("iban").setValue(expertIBAN)
      ref.child("Experts").child(userID).child("bankName").setValue(expertBankName)
      ref.child("Experts").child(userID).child("isPhonePrivate").setValue(expertAllowPhone)
      ref.child("Experts").child(userID).child("email").setValue(expertEmail)
      ref.child("Experts").child(userID).child("numOfRating").setValue(0)
      ref.child("Experts").child(userID).child("rating").setValue(0)
      ref.child("Experts").child(userID).child("ratingPoints").setValue(0)
        
      print("New Expert")
      checkCategory()

        
     var expertTitle = ""
        Database.database().reference().child("Experts").queryOrderedByKey().queryEqual(toValue: userID).observe(.value, with: { (DataSnapshot) in
            
            if(DataSnapshot.exists()){
                for (key , value) in self.expertTitle{
                    expertTitle += value + " . "
                    
                }
                self.ref.child("Experts").child(self.userID).child("title").setValue(expertTitle)
                self.performSegue(withIdentifier: "moveToHome", sender: self)

            }
            else{
                print("Not exist")
            }
                })
                
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButtin.backgroundColor = colors.selectedColor
     
        self.fillArrayOfButtons()
        self.getServices()
        isButtonClicked = false
        interestErrorLabel.isHidden = true
        dataLoadLabel.isHidden = true
        
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
