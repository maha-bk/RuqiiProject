//
//  customerOrders.swift
//  RuqiiSociety
//
//  Created by  on 9/4/17.
//  Copyright © 2017 abdllah aljohar. All rights reserved.
//

import UIKit

class customerOrders: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("move: ", tabbedBarSetting.move)
        if (tabbedBarSetting.move == true){
            self.performSegue(withIdentifier: "moveToOrderStep1", sender: self)

        }
        
        
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        print("move2: ", tabbedBarSetting.move)
        if (tabbedBarSetting.move == true){
            self.performSegue(withIdentifier: "moveToOrderStep1", sender: self)
            
        }
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
