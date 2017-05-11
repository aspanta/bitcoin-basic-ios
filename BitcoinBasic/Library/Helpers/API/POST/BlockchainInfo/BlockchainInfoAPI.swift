//
//  BlockchainInfoAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

class BlockchainInfoAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var param = super.parameters()
        let method = Constants.API.GetBlockchainInfo
        param["method"] = method
        
        return param
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let blockchain = Mapper<Blockchain>().map(JSON: data["result"] as! [String:AnyObject]) {
            super.apiDidReturnData(data: blockchain as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
