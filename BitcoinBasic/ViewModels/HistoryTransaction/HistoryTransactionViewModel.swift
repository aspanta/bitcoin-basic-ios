//
//  HistoryTransactionViewModel.swift
//  EmercoinBasic
//

import UIKit

class HistoryTransactionViewModel {

    var date:String = ""
    var address:String = ""
    var amount:String = ""
    var sign:String = "EMC"
    var imageTransactionDirection:UIImage? = nil
    
    init(historyTransaction:HistoryTransaction) {
        
        self.date = historyTransaction.date
        self.address = historyTransaction.address
        self.amount = String.coinFormat(at: historyTransaction.amount)
        
        let isIncoming = historyTransaction.direction() == .incoming
        
        let image = isIncoming ? "oper_rightarrow_icon" : "oper_leftarrow_icon"
        
        self.imageTransactionDirection = UIImage(named: image)
    }
}
