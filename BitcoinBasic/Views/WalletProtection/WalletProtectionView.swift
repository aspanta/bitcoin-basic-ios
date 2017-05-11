//
//  WalletProtectionView.swift
//  EmercoinBasic
//

import UIKit

class WalletProtectionView: PopupView {

    @IBOutlet internal weak var passwordTextField:BaseTextField!
    @IBOutlet internal weak var comfirmPasswordTextField:BaseTextField!
    @IBOutlet internal weak var doneButtun:UIButton!
    
    var encrypt:((_ text:String) -> (Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        passwordTextField.textChanged = {[weak self](text) in
            self?.validatePasswords()
        }
        comfirmPasswordTextField.textChanged = {[weak self](text) in
            self?.validatePasswords()
        }
    }
    
    override func doneButtonPressed(sender: UIButton) {
        if encrypt != nil {
            encrypt!(passwordTextField.text ?? "")
            super.doneButtonPressed(sender: sender)
        }
    }
    
    private func validatePasswords() {
        
        let password = passwordTextField.text ?? ""
        let confirmPassword = comfirmPasswordTextField.text ?? ""
        
        doneButtun.isEnabled = !password.isEmpty && password == confirmPassword
    }
}
