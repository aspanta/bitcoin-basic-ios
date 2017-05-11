//
//  DeleteNameAPI.swift
//  EmercoinBasic
//

import UIKit

class DeleteNameAPI: AddNameAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.DeleteName
        params["method"] = method
        
        return params
    }
}
