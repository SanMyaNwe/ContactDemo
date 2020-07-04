//
//  ContactPersistenceService.swift
//  Contact
//
//  Created by Riki on 7/2/20.
//  Copyright © 2020 SanMyaNwe. All rights reserved.
//

import Foundation
import CoreData

class ContactPersistenceService {
    
    static let shared = ContactPersistenceService()
    private init() {}
    
    private var service = PersistenceService.shared
    private var persistenceContainer = PersistenceService.shared.persistentContainer
    
    func saveContact(name: String, phoneNo: String) {
        
        let contactEntity = Contact(context: persistenceContainer.viewContext)
        
        contactEntity.id = UUID().uuidString
        contactEntity.name = name
        contactEntity.phoneNo = phoneNo
        
        save()
    }
    
    // FetchDataFromPersistence
    func fetchContacts() -> [Contact] {
        
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        
        do{
            
            let result = try persistenceContainer.viewContext.fetch(fetchRequest)
            return result
            
        }catch {
            print("Enable to fetch Contact.")
        }
        
        return []
    }
    
    func save() {
        service.saveContext()
    }
    
    //UpdateDataFromPersistence
    func updateContact(id: String, name: String, phoneNo: String) {
        
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        
        do {
            let result = try persistenceContainer.viewContext.fetch(fetchRequest)
            if result.count > 0 {
                let contact = result.first!
                contact.name = name
                contact.phoneNo = phoneNo
                save()
            }
            
        }catch {
            print("Unable to Update contact ...")
        }
    }
    
    //DeleteDataFromPersistence
    func deleteContact(with id: String) {
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        
        do {
            let result = try persistenceContainer.viewContext.fetch(fetchRequest)
            if result.count > 0 {
                persistenceContainer.viewContext.delete(result.first!)
                save()
            }
        }catch {
            print("Unable to delete Contact ...")
        }
    }
    
}
