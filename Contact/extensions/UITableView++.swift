//
//  UITableView++.swift
//  Contact
//
//  Created by Riki on 6/29/20.
//  Copyright © 2020 SanMyaNwe. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(with id: String) {
        
        let nib = UINib(nibName: id, bundle: nil)
        self.register(nib, forCellReuseIdentifier: id)
        
    }
}
