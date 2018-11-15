//
//  HistoryTableViewCell.swift
//  Insulin Dose Calc
//
//  Created by Grace Park on 11/8/18.
//  Copyright © 2018 Grace Park. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var bgLabel: UILabel!
    @IBOutlet weak var totalInsulinLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
