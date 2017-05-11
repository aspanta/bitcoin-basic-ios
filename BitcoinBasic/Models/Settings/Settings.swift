//
//  Settings.swift
//  EmercoinBasic
//

import UIKit
import SwiftyUserDefaults

let key = "login_info"

class Settings {
    
    var authInfo:[String:String]?
    
    func save() {
        Defaults.set(authInfo, forKey: key)
    }
    
    func load() {
        if let data = Defaults.value(forKey: key) {
            authInfo = data as? [String:String]
        }
    }
    
    func clear() {
        authInfo = nil
        Defaults[key] = nil
    }

}
