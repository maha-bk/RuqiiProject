
//  Settings.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 24/07/2017.
//  Copyright © 2017 Maha Alkatheiry. All rights reserved.

import UIKit

class Settings: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    var selectedIndex = 0
    var backToHome = false

    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Declaring the values of the table view cell's components.
 
    
    var ChoiceLabelArray = ["الملف الشخصي","أسعار الخدمات"]
    var Icons = [UIImage(named: "UserProfileIcon"),UIImage(named: "CostIcon")]
    var DetailsIconArray = [UIImage(named:"MoreIcon") , UIImage(named:"MoreIcon")]
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
    if (backToHome == true){
        backToHome = false
        let NextView = segue.destination as! ExpertHome
            NextView.ViewAppearsAfterSettings = true
        
    }
    
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        backToHome = true
        
        performSegue(withIdentifier: "ExpertHome", sender: self)
        
    }
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return ChoiceLabelArray.count
    }
    
    /*  In the follwoing function, the table view cell's components will be repeated with 
        different values based on the arrays declared previously at the top of this class.
        If the arrays containing 4 elements for each,
        then we will have 4 rows displayed in the table view*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomizedCell
        cell.ChoiceIcon.image = Icons [indexPath.row]
        cell.ChoiceTitle.text = ChoiceLabelArray [indexPath.row]
        cell.DetailsIcon.image = DetailsIconArray [indexPath.row]
        return cell
    
    }
    
    
  /*This function is responsible to direct the user to the correct interface
   based on the selected row */
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
       selectedIndex = indexPath.row
        switch selectedIndex {
        case 0:
            performSegue(withIdentifier: "profileSettings", sender: self)
        case 1:
            performSegue(withIdentifier: "servicesPrices", sender: self)
    
        default:
            print("Index greater than the list")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.title = "الإعدادات"
    }


}// end of Settings class
