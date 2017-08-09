//
//  MyAddressBook.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class MyAddressBook: AddressBook {
    
    func addressesArray() -> [String] {
        
        return contacts.map({!$0.name.isEmpty ? $0.name : $0.address})
    }
    
    override var contacts: Results<Contact> {
        get {
            let realm = try! Realm()
            return realm.objects(Contact.self).filter("isMyContact == true")
        }
    }
    
    override func load(loadAll:Bool? = false) {
        
        activityIndicator.onNext(true)
        
        APIManager.sharedInstance.loadMyAddresses {[weak self] (data, error) in
            
            self?.activityIndicator.onNext(false)
            
            if error == nil {
                if loadAll == true {
                    APIManager.sharedInstance.loadAll()
                }
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
        }
    }
    
    func processingAndAdd(at addresses:[String]) {
        
        var array:[Contact] = []
        
        for i in 0...addresses.count - 1 {
            
            let address = addresses[i]
            
            if self.contacts.filter("address = %@",address).count == 0 {
                let name = ""
                
                array.append(Contact(value:["name": name, "address": addresses[i], "isMyContact":true]))
            }
        }
        
        if array.count > 0 {
            add(contacts: array)
        }
        
        removeNotUsedAddresses(at: addresses)
    }
    
    private func removeNotUsedAddresses(at addresses:[String]) {
        
        var array:[Contact] = []
        
        for contact in contacts {
            
            if !addresses.contains(contact.address) {
                array.append(contact)
            }
        }
        
        if array.count > 0 {
            self.remove(contacts: array)
        }
        
    }
    
    override func addNewMyAddress(at name:String) {
        
        activityIndicator.onNext(true)
        
        APIManager.sharedInstance.loadMyNewAddress {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            
            if error == nil {
                guard let address = data as? String else {
                    return
                }
            
                self?.add(contact: Contact(value:["name": name, "address": address, "isMyContact":true]))
        
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
            
        }
    }
}
