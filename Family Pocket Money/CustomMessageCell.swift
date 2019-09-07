//
//  CustomMessageCell.swift
//  Family Pocket Money
//
//  Created by Aleksandr Ozhogin on 5/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    
    @IBOutlet weak var messageBackground: UIView!
    
    @IBOutlet weak var userMessageLabel: UILabel!
    
    @IBOutlet weak var textMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
