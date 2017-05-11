//
//  MyAdressViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension MyAdressViewController {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = addressBook.contacts.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MyAddressCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        let viewModel = ContactViewModel(contact:itemAt(indexPath: indexPath))
        cell.object = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let contact = itemAt(indexPath: indexPath)
        UIPasteboard.general.string = contact.address
        
        showCopyView()
    }
    
    private func showCopyView() {
        
        let copyView:UIView = loadViewFromXib(name: "AddressBook", index: 3,
                                              frame: nil)
        copyView.alpha = 0;
        view.addSubview(copyView)
        
        copyView.center = view.center
        
        UIView.animate(withDuration: 0.3) {
            copyView.alpha = 0.8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3, animations: {
                copyView.alpha = 0.0
            }, completion: { (state) in
                copyView.removeFromSuperview()
            })
        }
    }
    
    internal func itemAt(indexPath:IndexPath) -> Contact {
        return addressBook.contacts[indexPath.row]
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editImage = UIImageView(image: UIImage(named: "edit_icon"))
        editImage.contentMode = .scaleAspectFit
        
        let editAction = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            self.addEditContactViewWith(indexPath: indexPath)
        }
        
        editAction.backgroundColor = UIColor(patternImage:editImage.image!)
        return [editAction]
    }
    
    private func addEditContactViewWith(indexPath:IndexPath) {
        
        let editContactView = loadViewFromXib(name: "AddressBook", index: 2,
                                              frame: self.parent!.view.frame) as! AddAddressView
        let contact = itemAt(indexPath: indexPath)
        editContactView.viewModel = ContactViewModel(contact: contact)
        
        editContactView.add = ({(name) in
            self.addressBook.update(at: name, index:indexPath.row)
            self.reloadRows(at: [indexPath])
        })
        self.parent?.view.addSubview(editContactView)
    }
    
    private func reloadRows(at indexPaths:[IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indexPaths, with: .none)
        self.tableView.endUpdates()
    }
}
