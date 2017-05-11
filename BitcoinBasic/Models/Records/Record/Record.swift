//
//  BCNote.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RealmSwift

let blocksInDay = 175

class Record: Object, Mappable {
    
    dynamic var name = ""
    dynamic var value = ""
    dynamic var address = ""
    dynamic var isExpired = false
    dynamic var isDeleted = false
    dynamic var isMyRecord = true
    
    dynamic var expiresIn = 0 {
        didSet{
            expiresInDays = Int((Double(expiresIn)/Double(blocksInDay)).rounded())
        }
    }
    dynamic var expiresInDays = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        address <- map["address"]
        value <- map["value"]
        expiresIn <- map["expires_in"]
        isExpired <- map["expired"]
        isDeleted <- map["deleted"]
    }
}
