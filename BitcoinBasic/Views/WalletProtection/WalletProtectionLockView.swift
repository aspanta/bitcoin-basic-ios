//
//  WalletProtectionLockView.swift
//  EmercoinBasic
//

import UIKit

class WalletProtectionLockView: PopupView {

    var lock:(() -> (Void))?
    
    override func doneButtonPressed(sender: UIButton?) {
        if lock != nil {
            lock!()
            super.doneButtonPressed(sender: sender)
        }
    }
}
