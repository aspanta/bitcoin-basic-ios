//
//  UpdateNameAPI.swift
//  EmercoinBasic
//

import UIKit

class UpdateNameAPI: AddNameAPI {
    
    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.UpdateName
        params["method"] = method
        
//        guard let data = object as? [String:AnyObject] else {
//            return params
//        }
//        
//        if let nameData = data["nameData"] {
//            params["params"] = nameData
//        }
        
        return params
    }

}
