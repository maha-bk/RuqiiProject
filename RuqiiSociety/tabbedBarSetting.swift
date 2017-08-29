

import UIKit

class tabbedBarSetting: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = colors.selectedColor
        self.tabBar.tintColor = UIColor.init(red: 78/255 , green: 193/255 , blue: 187/255, alpha: 1)
        setupMiddleButton()
    }
    
 
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 69))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = self.view.bounds.width / 2 - menuButtonFrame.size.width / 2
        menuButton.frame = menuButtonFrame
    

        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        self.view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(named: "tweetButton"), for: UIControlState.normal)
       
        menuButton.addTarget(self, action: #selector(tabbedBarSetting.menuButtonAction), for: UIControlEvents.touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    // Add new Order button Touch Action
    func menuButtonAction(sender: UIButton) {
   
    }



}
