//
//  PersistenceServiceListener.swift
//  Contact
//
//  Created by Riki on 7/2/20.
//  Copyright © 2020 SanMyaNwe. All rights reserved.
//

import Foundation

protocol PersistenceServiceListener {
    func persistenceContactDidChange()
}

extension PersistenceServiceListener {
    func persistenceContactDidChange() {}
}
