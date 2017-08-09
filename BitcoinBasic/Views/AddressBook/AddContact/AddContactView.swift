//
//  AddContactView.swift
//  EmercoinBasic
//

import UIKit

class AddContactView: PopupView {

    @IBOutlet weak var nameTextField:BaseTextField!
    @IBOutlet weak var addressTextField:BaseTextField!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var doneButton:UIButton!

    var add:((_ name:String, _ address:String) -> (Void))?
    
    var viewModel:ContactViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextField.textChanged = {[weak self](text) in
            self?.validateFields()
        }
        addressTextField.textChanged = {[weak self](text) in
            self?.validateFields()
        }
        
    }
    
    private func validateFields() {
        
        let name = nameTextField.text ?? ""
        let address = addressTextField.text ?? ""
        doneButton.isEnabled = !name.isEmpty && address.validAddress()
    }
    
    private func updateUI() {
        
        if viewModel != nil {
            titleLabel.text = "Edit contact"
            doneButton.setTitle("Save", for: .normal)
            nameTextField.text = viewModel?.name
            addressTextField.text = viewModel?.address
            doneButton.isEnabled = true
        }
    }
    
    @IBAction override func doneButtonPressed(sender:UIButton?) {
        
        let name = nameTextField.text
        let address = addressTextField.text
        
        if add != nil && ((name?.length)! > 0 && (address?.length)! > 0 ) {
            add!(name!, address!)
        } else {
            return
        }
        super.doneButtonPressed(sender: sender)
    }
}
