//
//  BaseModel.swift
//  Emercoin Basic
//

import UIKit
import ObjectMapper

class BaseModel: NSObject, Mappable {
    
    var id:Int?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
       
    }
    
    func mapping(map: Map) {
         id <- map["id"]
    }
}
