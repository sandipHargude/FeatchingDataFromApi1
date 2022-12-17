//
//  UserTableViewCell.swift
//  CompanyTask2
//
//  Created by Mac on 17/12/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
