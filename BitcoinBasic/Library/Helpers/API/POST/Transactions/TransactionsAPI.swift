//
//  TransactionsAPI.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper

let maxTransactions = 100

class TransactionsAPI: BaseAPI {
    
    override func parameters() -> [String : Any] {
        
        var param = super.parameters()
        let method = Constants.API.GetTransactions
        param["method"] = method
        param["params"] = ["",maxTransactions,0,true]
        return param
    }
    
    override func apiDidReturnData(data: AnyObject) {
        
        if let transactions = Mapper<HistoryTransaction>().mapArray(JSONArray: data["result"] as! [[String:AnyObject]]) {
            
            let history = History()
            history.removeAll()
            history.add(transactions: transactions)
            
            super.apiDidReturnData(data: transactions as AnyObject)
        } else {
            super.apiDidReturnData(data: data)
        }
    }
}
