//
//  MyAddressesAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper


class MyAddressesAPI: BaseAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.GetMyAddresses
        params["method"] = method
        params["params"] = [""]
        
        return params
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let addresses = data["result"] as? [String]  {
            
            let book = MyAddressBook()
            book.processingAndAdd(at: addresses)
            
            super.apiDidReturnData(data: addresses as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
