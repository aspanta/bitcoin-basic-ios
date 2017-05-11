//
//  SendAmountTextField.swift
//  EmercoinBasic
//

import UIKit

class SendAmountTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
    }

}

extension SendAmountTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text!
        
//        if string == "," {
//            textField.text = text+"."
//            return false
//        }
        
        let fullText = textField.text!+string
        return  fullText.length <= Constants.Controllers.Send.MaxCountNumbers
    }
}
