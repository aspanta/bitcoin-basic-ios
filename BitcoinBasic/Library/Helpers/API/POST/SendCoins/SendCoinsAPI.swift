//
//  SendCoinsAPI.swift
//  EmercoinBasic
//

import UIKit

class SendCoinsAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.SendCoins
        params["method"] = method
        
        guard let data = object as? [String:AnyObject] else {
            return params
        }
    
        if let sendData = data["sendData"] {
            params["params"] = sendData
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
