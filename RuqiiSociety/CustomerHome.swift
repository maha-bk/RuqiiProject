
//  CustomerHome.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 16/08/2017.
//  Copyright © 2017 Maha Alkathiery. All rights reserved.

import UIKit

class CustomerHome: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        tabbedBarSetting.menuButton.addTarget(self, action: #selector(self.menuButtonAction), for: UIControlEvents.touchUpInside)
        
        
        
        
    }// end of ViewWillAppear function
    
    
    // Add new Order button Touch Action
    func menuButtonAction(sender: UIButton) {
        print("hello")
        //self.performSegue(withIdentifier: "move", sender: self)

        //self.performSegue(withIdentifier: "moveToOrderStep1", sender: self)
        let move = self.storyboard?.instantiateViewController(withIdentifier: "orderStep1") as! orderStep1
        self.present(move, animated: true, completion: nil)
        //self.pushViewController(move, animated: true)

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabbedBarSetting.menuButton.addTarget(self, action: #selector(self.menuButtonAction), for: UIControlEvents.touchUpInside)
        self.definesPresentationContext = true
        
        
    }// end of viewDidLoad function
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }// end of idReceiveMemoryWarning function
    
    
    
}// end of CustomerHome class
