//
//  SuccessSendView.swift
//  EmercoinBasic
//

import UIKit

class SuccessSendView: PopupView {
    
    var success:((Void) -> (Void))?
    
    @IBAction override func doneButtonPressed(sender:UIButton) {
        
        if success != nil {
            success!()
        }
        super.doneButtonPressed(sender: sender)
    }
}
