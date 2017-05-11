//
//  UnlockWalletAPI.swift
//  EmercoinBasic
//

import UIKit

class UnlockWalletAPI: BaseAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.UnlockWallet
        params["method"] = method
        
        guard let data = object as? [String:AnyObject] else {
            return params
        }
        
        if let unlockData = data["unlockData"] {
            params["params"] = unlockData
        }
        
        return params
    }
}
