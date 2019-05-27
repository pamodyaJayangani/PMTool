//
//  CustomTaskTableViewCell.swift
//  PMTool
//
//  Created by Pamodya Jayangani on 5/25/19.
//  Copyright © 2019 Pamodya Jayangani. All rights reserved.
//

import UIKit

class CustomTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
