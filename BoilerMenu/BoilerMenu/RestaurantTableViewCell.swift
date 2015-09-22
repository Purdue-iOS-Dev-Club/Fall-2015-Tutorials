//
//  RestaurantTableViewCell.swift
//  BoilerMenu
//
//  Created by George Lo on 9/21/15.
//  Copyright © 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var restaurantIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
