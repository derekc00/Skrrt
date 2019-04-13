//
//  DetailsCell.swift
//  Skrrt
//
//  Created by Derek Chang on 4/13/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var moneyBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.cornerRadius = 4
        moneyBackground.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
    
    
    func setRounded() {
        let radius = self.frame.height/2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
