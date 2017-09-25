
//  CustomizedCell.swift
//  RuqiiSociety
//  Created by Maha Alkatheiry on 25/07/2017.
//  Copyright © 2017 Maha Alkatheiry. All rights reserved.

/*This class is created to declare the table view cell's components in
 the Settings interface. These components are filled with their values by the Settings class using
 tableView cellForRowAt function */
import UIKit

class CustomizedCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    @IBOutlet weak var DetailsIcon: UIImageView!
    @IBOutlet weak var ChoiceTitle: UILabel!
    @IBOutlet weak var ChoiceIcon: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}// end of CustomizedCell class
