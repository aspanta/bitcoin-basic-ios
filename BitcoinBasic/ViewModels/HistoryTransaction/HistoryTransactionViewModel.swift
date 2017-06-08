//
//  HistoryTransactionViewModel.swift
//  EmercoinBasic
//

import UIKit

class HistoryTransactionViewModel {
    
    var date:String = ""
    var dateFull:String = ""
    var address:String = ""
    var amount:String = ""
    var sign:String = "BTC"
    var category:String = ""
    var fee:String = ""
    var vout:String = ""
    var blockhash:String = ""
    var transactionId = ""
    var isConfirmed = true
    var imageTransactionDirection:UIImage? = nil
    
    init(historyTransaction:HistoryTransaction) {
        
        self.date = historyTransaction.date
        self.dateFull =  historyTransaction.dateFull
        self.address = historyTransaction.address
        self.amount = String.dropZeroLast(at: String.coinFormat(at: historyTransaction.amount))
        self.fee = String(historyTransaction.fee)
        self.vout = String(historyTransaction.vout)
        self.blockhash = historyTransaction.confirmations == 0 ? "unconfirmed" : String(historyTransaction.blockhash)
        self.transactionId = historyTransaction.transactionId
        self.isConfirmed = historyTransaction.confirmations > 0
        let isIncoming = historyTransaction.direction() == .incoming
        
        category = isIncoming ? "Receive" : "Send"
        
        let image = isIncoming ? "oper_rightarrow_icon" : "oper_leftarrow_icon"
        self.imageTransactionDirection = UIImage(named: image)
    }
}
