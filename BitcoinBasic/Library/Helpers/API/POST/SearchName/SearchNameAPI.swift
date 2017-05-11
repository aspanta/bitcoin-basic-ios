//
//  SearchNameAPI.swift
//  EmercoinBasic
//


import UIKit
import ObjectMapper

class SearchNameAPI: BaseAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.SearchName
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
        
        if let record = Mapper<Record>().map(JSON: data["result"] as! [String:AnyObject]) {
            super.apiDidReturnData(data: record as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
