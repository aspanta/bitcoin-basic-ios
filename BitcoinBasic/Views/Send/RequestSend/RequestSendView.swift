//
//  RequestSendView.swift
//  EmercoinBasic
//

import UIKit

class RequestSendView: PopupView {
    
    @IBOutlet private weak var amountLabel:UILabel?
    
    var sendCoins:((Void) -> (Void))?
    
    var amount:String = "" {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        let requestString = String(format:"Do you want to send to the address %@ EMC?",amount)
        amountLabel?.text = requestString
    }
    
    @IBAction override func doneButtonPressed(sender:UIButton) {
        if sendCoins != nil {
            sendCoins!()
            cancelButtonPressed(sender: nil)
        }
        super.doneButtonPressed(sender: sender)
    }
}
