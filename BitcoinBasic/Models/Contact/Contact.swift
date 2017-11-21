//
//  Contact.swift
//  EmercoinBasic
//

import UIKit
import RealmSwift

class Contact: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var isMyContact = false
    
}
