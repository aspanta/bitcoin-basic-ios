
//
//  AddNameAPI.swift
//  EmercoinBasic
//

import UIKit

class AddNameAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.AddName
        params["method"] = method
        
        guard let data = object as? [String:AnyObject] else {
            return params
        }
        
        if let nameData = data["nameData"] {
            params["params"] = nameData
        }
        
        return params
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let result = data["result"] as? String  {
            let success = result.length > 0
            super.apiDidReturnData(data: success as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
