//
//  AddressBookViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension AddressBookViewController {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = addressBook.contacts.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ContactCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        let viewModel = ContactViewModel(contact: itemAt(indexPath: indexPath))
        cell.object = viewModel
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = itemAt(indexPath: indexPath)
        if selectedAddress != nil {
            selectedAddress!(item.address)
            self.back()
        }
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteImage = UIImageView(image: UIImage(named: "delete_icon"))
        let editImage = UIImageView(image: UIImage(named: "edit_icon"))
        deleteImage.contentMode = .scaleAspectFit
        editImage.contentMode = .scaleAspectFit
        
        let editAction = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            self.addEditContactViewWith(indexPath: indexPath)
        }
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            self.addDeleteContactViewWith(indexPath: indexPath)
        }
        deleteAction.backgroundColor = UIColor(patternImage:deleteImage.image!)
        editAction.backgroundColor = UIColor(patternImage:editImage.image!)
        return [deleteAction, editAction]
    }
    
    private func removeCellAt(indexPath:IndexPath) {
        
        let item = itemAt(indexPath: indexPath)
        addressBook.remove(contact: item)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .top)
        tableView.endUpdates()
        self.updateUI()
    }
    
    private func addDeleteContactViewWith(indexPath:IndexPath) {
            
        let deleteContactView = loadViewFromXib(name: "AddressBook", index: 0,
                                                               frame: self.parent!.view.frame) as! DeleteContactView
        deleteContactView.delete = ({
            self.removeCellAt(indexPath: indexPath)
        })
        
        deleteContactView.cancel = ({
            self.reloadRows(at: [indexPath])
        })
        
        self.parent?.view.addSubview(deleteContactView)
    }
    
    private func addEditContactViewWith(indexPath:IndexPath) {
        
        let editContactView = loadViewFromXib(name: "AddressBook", index: 1,
                                                                   frame: self.parent!.view.frame) as! AddContactView
        let contact = itemAt(indexPath: indexPath)
        editContactView.viewModel = ContactViewModel(contact: contact)
        
        editContactView.add = ({[weak self](name, address) in
            
            self?.addressBook.update(at: name, address: address, index: indexPath.row)
            self?.reloadRows(at: [indexPath])
        })
        self.parent?.view.addSubview(editContactView)
    }
    
    private func reloadRows(at indexPaths:[IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indexPaths, with: .none)
        self.tableView.endUpdates()
    }
    
    private func itemAt(indexPath:IndexPath) -> Contact {
        return addressBook.contacts[indexPath.row]
    }
}
