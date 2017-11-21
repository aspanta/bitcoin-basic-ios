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
    
    @objc dynamic var amount:Double = 0
    @objc dynamic var fee:Double = 0
    @objc dynamic var vout:Int = 0
    @objc dynamic var confirmations:Int = 0
    @objc dynamic var date = ""
    @objc dynamic var dateFull = ""
    @objc dynamic var blockhash = ""
    @objc dynamic var transactionId = ""
    @objc dynamic var timereceived:TimeInterval = 0 {
        didSet {
            date = Date(timeIntervalSince1970: timereceived).transactionStringDate()
            dateFull = Date(timeIntervalSince1970: timereceived).transactionStringDateFull()
        }
    }
    
    @objc dynamic var address = ""
    @objc dynamic var category = ""
    
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
        blockhash <- map["blockhash"]
        transactionId <- map["txid"]
        fee <- map["fee"]
        vout <- map["vout"]
        confirmations <- map["confirmations"]
    }
}
