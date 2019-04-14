//
//  ProfileHistoryCell.swift
//  Skrrt
//
//  Created by Derek Chang on 4/14/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit

class ProfileHistoryCell: UITableViewCell {

    
    
    
    @IBOutlet weak var isAvaliableLabel: UILabel!
    
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var seats: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
