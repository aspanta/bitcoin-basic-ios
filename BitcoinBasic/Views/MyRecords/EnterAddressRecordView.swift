//
//  EnterAddressRecordView.swift
//  EmercoinBasic
//

import UIKit

class EnterAddressRecordView: PopupView {

    @IBOutlet internal weak var addressTextField:BaseTextField!
    @IBOutlet internal weak var doneButton:BaseButton!

    var text:((_ text:String) -> (Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressTextField.textChanged = {[weak self] text in
            self?.doneButton.isEnabled = text.validAddress()
        }
    }

    @IBAction override func doneButtonPressed(sender:UIButton) {
        
        if text != nil {
            text!(addressTextField.text!)
        }
        super.doneButtonPressed(sender: sender)
    }
}
