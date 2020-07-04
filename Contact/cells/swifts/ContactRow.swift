//
//  ContactRow.swift
//  Contact
//
//  Created by Riki on 6/29/20.
//  Copyright © 2020 SanMyaNwe. All rights reserved.
//

import UIKit

class ContactRow: UITableViewCell {
    
    static let identifier = "ContactRow"

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(with contact: Contact) {
        lblName.text = contact.name
        lblPhoneNo.text = contact.phoneNo
    }
    
}
