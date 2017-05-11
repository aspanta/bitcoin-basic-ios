//
//  NamesAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

class NamesAPI: BaseAPI {

    override func parameters() -> [String : Any] {
        
        var params = super.parameters()
        let method = Constants.API.GetNames
        params["method"] = method
        
        return params
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let names = Mapper<Record>().mapArray(JSONArray: data["result"] as! [[String:AnyObject]]) {
        
            let records = Records()
            records.removeAll()
            records.add(records: names.filter({ (record) -> Bool in
                return record.isExpired == false
            }))
            
            super.apiDidReturnData(data: names as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
