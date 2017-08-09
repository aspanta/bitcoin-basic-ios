//
//  LockWalletAPI.swift
//  EmercoinBasic
//

import UIKit

class LockWalletAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.LockWallet
        params["method"] = method
        
        return params
    }
}
