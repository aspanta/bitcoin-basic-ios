//
//  HistoryTransaction.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RealmSwift

enum TransactionDirection:Int {
    case incoming = 0
    case outcoming = 1
}

class HistoryTransaction:Object, Mappable {
    
    dynamic var amount:Double = 0
    dynamic var fee:Double = 0
    dynamic var vout:Int = 0
    dynamic var date = ""
    dynamic var dateFull = ""
    dynamic var blockhash = ""
    dynamic var transactionId = ""
    dynamic var stringDate = "" {
        didSet {
            
            var string = stringDate
            let array = stringDate.components(separatedBy: ".")
            if array.count == 2 {
                string = array.first ?? stringDate
            }
            
            date = Date.fromString(string: string).transactionStringDate()
            dateFull = Date.fromString(string: string).transactionStringDateFull()
        }
    }
    dynamic var address = ""
    
    dynamic var category = 0
    
    func direction() -> TransactionDirection {
        return TransactionDirection(rawValue: category)!
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        address <- map["address"]
        stringDate <- map["date"]
        category <- map["category"]
        blockhash <- map["blockhash"]
        transactionId <- map["txid"]
        fee <- map["fee"]
        vout <- map["vout"]
    }
}
