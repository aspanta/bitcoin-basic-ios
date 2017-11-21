//
//  BlockchainObject.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RealmSwift

class Blockchain: Object, Mappable {

    @objc dynamic var blocks = 0
    @objc dynamic var headers = 0
    @objc dynamic var verificationprogress = 0.0 {
        didSet {
            isLoaded = !((verificationprogress < 0.99) || (blocks + 1 < headers))
        }
    }
    @objc dynamic var isLoaded = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        blocks <- map["blocks"]
        headers <- map["headers"]
        verificationprogress <- map["verificationprogress"]
    }
}
