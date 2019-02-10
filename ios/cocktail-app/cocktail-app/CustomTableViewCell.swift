//
//  CustomTableViewCell.swift
//  cocktail-app
//
//  Created by Colin Watson on 2/8/19.
//  Copyright © 2019 Colin Watson. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var drinkImageView: UIImageView!
    @IBOutlet var drinkTitle: UILabel!
    @IBOutlet var drinkDescription: UILabel!
    
    @IBOutlet var favButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
