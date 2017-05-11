//
//  WalletProtectionUnlockView.swift
//  EmercoinBasic
//

import UIKit

class WalletProtectionUnlockView: PopupView {
    
    @IBOutlet internal weak var passwordTextField:BaseTextField!
    @IBOutlet internal weak var doneButtun:UIButton!
    
    var unlock:((_ text:String) -> (Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        passwordTextField.textChanged = {[weak self](text) in
            self?.validatePasswords()
        }
    }
    
    override func doneButtonPressed(sender: UIButton) {
        if unlock != nil {
            unlock!(passwordTextField.text ?? "")
            super.doneButtonPressed(sender: sender)
        }
    }
    
    private func validatePasswords() {
        
        let password = passwordTextField.text ?? ""
        doneButtun.isEnabled = !password.isEmpty
    }
}
