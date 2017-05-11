//
//  HistoryTransaction.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RealmSwift

enum TransactionDirection:String {
    case incoming = "receive"
    case outcoming = "send"
}

class HistoryTransaction:Object, Mappable {
    
    dynamic var amount:Double = 0
    dynamic var date = ""
    dynamic var address = ""
    
    dynamic var timereceived:TimeInterval = 0 {
        didSet {
            date = Date.init(timeIntervalSince1970: timereceived).transactionStringDate()
        }
    }
    
    dynamic var category = ""
    
    func direction() -> TransactionDirection {
        return TransactionDirection(rawValue: category)!
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        address <- map["address"]
        timereceived <- map["timereceived"]
        category <- map["category"]
    }
}
