//
//  InfoAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

class InfoAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var param = super.parameters()
        let method = Constants.API.GetInfo
        param["method"] = method
        
        return param
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let wallet = Mapper<Wallet>().map(JSON: data["result"] as! [String:AnyObject]) {
            super.apiDidReturnData(data: wallet as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
