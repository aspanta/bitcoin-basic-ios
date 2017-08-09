//
//  FeeAPI.swift
//  BitcoinBasic
//

import UIKit

class FeeAPI: BaseAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.Fee
        params["method"] = method
        
        guard let data = object as? [String:AnyObject] else {
            return params
        }
        
        if let fee = data["fee"] {
            params["params"] = fee
        }
        
        return params
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let result = data["result"] as? Bool  {
            super.apiDidReturnData(data: result as AnyObject)
        }
    }
}
