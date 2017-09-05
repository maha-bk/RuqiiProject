

import UIKit

class tabbedBarSetting: UITabBarController{
    static var move = Bool()
    static let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 74, height: 79))
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = colors.selectedColor
        //self.tabBar.tintColor = UIColor.init(red: 78/255 , green: 193/255 , blue: 187/255, alpha: 1)
 
        // to move the two tab items  to be not very near to the menu button
        tabBar.items?[1].titlePositionAdjustment = UIOffsetMake(-15.0 , 0.0)
        tabBar.items?[2].titlePositionAdjustment = UIOffsetMake(15.0 , 0.0)
        
        // to set diffrent tint color title and image to each tab bar item whem it is selected
        self.tabBar.items?[0].selectedImage = UIImage(named: "icoHomeSelected")
        self.tabBar.items?[0].setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(red: 78/255 , green: 193/255 , blue: 187/255, alpha: 1)], for: .selected)
        
        self.tabBar.items?[1].selectedImage = UIImage(named: "icoOrdersSelected")
        self.tabBar.items?[1].setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(red: 173/255 , green: 208/255 , blue: 54/255, alpha: 1)], for: .selected)
        
        self.tabBar.items?[2].selectedImage = UIImage(named: "icoNotificationsSelected")
        self.tabBar.items?[2].setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(red: 251/255 , green: 177/255 , blue: 22/255, alpha: 1)], for: .selected)
        
        self.tabBar.items?[3].setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)

  
        setupMiddleButton()
    }
    
 
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        //let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 74, height: 79))
        var menuButtonFrame = tabbedBarSetting.menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = self.view.bounds.width / 2 - menuButtonFrame.size.width / 2
        tabbedBarSetting.menuButton.frame = menuButtonFrame
    

        tabbedBarSetting.menuButton.layer.cornerRadius = menuButtonFrame.height/2
        self.view.addSubview(tabbedBarSetting.menuButton)
        
        tabbedBarSetting.menuButton.setImage(UIImage(named: "tweetButton"), for: UIControlState.normal)
        
               

        //add touchUpInside action to the button
               
        self.view.layoutIfNeeded()
    }
    


        
        
    


}
