//
//  MVVMCItemTableViewCell.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

class MVVMCItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var item: DataItem? {
        didSet {
            if let item = item {
                nameLabel.text = item.name
            } else {
                nameLabel.text = "Unknown"
            }
        }
    }

}
