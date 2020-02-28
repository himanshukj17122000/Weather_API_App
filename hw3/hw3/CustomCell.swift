//
//  CustomCell.swift
//  hw3
//
//  Created by himanshu on 28/02/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    
    @IBOutlet weak var cellTemp: UILabel!
    @IBOutlet weak var cellName: UILabel!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

