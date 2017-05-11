//
//  WalletProtectionWarningView.swift
//  EmercoinBasic
//

import UIKit

class WalletProtectionWarningView: PopupView {
    
    var encrypt:((Void) -> (Void))?
    
    override func doneButtonPressed(sender: UIButton) {
        if encrypt != nil {
            encrypt!()
            super.doneButtonPressed(sender: sender)
        }
    }
}
