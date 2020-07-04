//
//  HomeView.swift
//  Contact
//
//  Created by Riki on 6/29/20.
//  Copyright © 2020 SanMyaNwe. All rights reserved.
//

import UIKit

class HomeView: UIViewController {

    private var contacts: [Contact] = [Contact]()
    private var searchContact = [Contact]()
    private var searching = false
    
    @IBOutlet weak var contactSearchBar: UISearchBar!
    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PersistenceService.shared.listener = self
        contacts = ContactPersistenceService.shared.fetchContacts()
        setUpTableView()
    }
    
    func setUpTableView() {
        contactTableView.dataSource = self
        contactTableView.delegate = self
        
        contactTableView.showsVerticalScrollIndicator = false
        contactTableView.rowHeight = 60
        contactTableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        contactTableView.register(with: ContactRow.identifier)
    }
    
    
    @IBAction func onClickAdd(_ sender: Any) {
        
        let alert = UIAlertController(title: "Save Contact", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (txtName) in
            txtName.placeholder = "Enter Name"
        }
        
        alert.addTextField { (txtPhoneNo) in
            txtPhoneNo.placeholder = "Enter Phone Number"
        }
        
        let btnSave = UIAlertAction(title: "Save", style: .destructive) { _ in
            let name = alert.textFields![0].text ?? ""
            let phoneNo = alert.textFields![1].text ?? ""
            
            if phoneNo.isEmpty {
                
            }
            
            ContactPersistenceService.shared.saveContact(name: name, phoneNo: phoneNo)
        }
        
        let btnCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(btnSave)
        alert.addAction(btnCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching) {
            return searchContact.count
        } else {
            return contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactRow.identifier, for: indexPath) as! ContactRow
        cell.selectionStyle = .none
        
        if(searching) {
            cell.bindData(with: searchContact[indexPath.row])
        } else {
            cell.bindData(with: contacts[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contact = contacts[indexPath.row]
        
        let alert = UIAlertController(title: "Update Contact", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (txtName) in
            txtName.placeholder = "Enter Name"
            txtName.text = contact.name
        }
        
        alert.addTextField { (txtPhoneNo) in
            txtPhoneNo.placeholder = "Enter Phone Number"
            txtPhoneNo.text = contact.phoneNo
        }
        
        let btnUpdate = UIAlertAction(title: "Update", style: .destructive) { _ in
            let name = alert.textFields![0].text ?? ""
            let phoneNo = alert.textFields![1].text ?? ""
            ContactPersistenceService.shared.updateContact(id: contact.id!, name: name, phoneNo: phoneNo)
        }
        
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(btnUpdate)
        alert.addAction(btnCancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let contact = contacts[indexPath.row]
        
        if editingStyle == .delete {
            ContactPersistenceService.shared.deleteContact(with: contact.id ?? "")
        }
    }
}

extension HomeView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchContact = contacts.filter({$0.name == searchText})
        searching = true
        contactTableView.reloadData()
    }
}

extension HomeView: PersistenceServiceListener {
    func persistenceContactDidChange() {
        contacts = ContactPersistenceService.shared.fetchContacts()
        contactTableView.reloadData()
    }
}
