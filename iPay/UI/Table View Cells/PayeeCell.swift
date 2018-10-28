//
//  PayeeCell.swift
//  iPay
//
//  Created by Ramesh on 01/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation
import UIKit


class PayeeCell: UITableViewCell {
    
    @IBOutlet var payeeImageView: UIImageView!
    @IBOutlet var payeeName: UILabel!
    @IBOutlet var payeeAccountNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
