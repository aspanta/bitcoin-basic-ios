//
//  AppManager.swift
//  EmercoinBasic
//

import UIKit
import RealmSwift

class AppManager {
    
    internal static let sharedInstance = AppManager()
    
    var wallet:Wallet = Wallet(amount: -1)
    var myAddressBook:MyAddressBook = MyAddressBook()
    var settings:Settings = {
        let settings = Settings()
        settings.load()
        return settings
    }()
    
    var isAuthorized = false
    var isBlockchaiLoaded = false
    
    func logOut() {
        
        isAuthorized = false
        settings.clear()
        APIManager.sharedInstance.cancelAllRequests()
        wallet.balance = -1
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        Router.sharedInstance.showLoginController()
    }

}
