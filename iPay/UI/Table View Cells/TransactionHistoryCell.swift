//
//  TransactionHistoryCell.swift
//  iPay
//
//  Created by Ramesh on 01/12/16.
//  Copyright © 2016 Aspire Syatems. All rights reserved.
//

import Foundation
import UIKit

class TransactionHistoryCell: UITableViewCell {
    

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var payeeNameLabel: UILabel!
    @IBOutlet var payeeAccountNo: UILabel!
    @IBOutlet var transactionDate: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
