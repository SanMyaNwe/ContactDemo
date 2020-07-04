//
//  PersistenceService.swift
//  Contact
//
//  Created by Riki on 7/2/20.
//  Copyright © 2020 SanMyaNwe. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    
    static let shared = PersistenceService()
    private init(){}
    
    var listener: PersistenceServiceListener? = nil
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ContactsDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
