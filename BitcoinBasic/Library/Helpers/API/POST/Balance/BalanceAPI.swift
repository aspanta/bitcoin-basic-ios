//
//  BalanceAPI.swift
//  EmercoinBasic
//

import UIKit

class BalanceAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var param = super.parameters()
        let method = Constants.API.GetBalance
        param["method"] = method
        
        return param
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let balance = data["result"] as? Double  {
            
            let wallet = AppManager.sharedInstance.wallet
            wallet.balance = balance
            
            super.apiDidReturnData(data: balance as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
