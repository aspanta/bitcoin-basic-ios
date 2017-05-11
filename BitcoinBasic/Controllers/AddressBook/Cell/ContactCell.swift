//
//  ContactCell.swift
//  EmercoinBasic
//

import UIKit

class ContactCell: BaseTableViewCell {
    
    @IBOutlet weak var nameLabeL:UILabel!
    @IBOutlet weak var addressLabeL:UILabel!
    
    override func updateUI() {
        
        guard let viewModel = object as? ContactViewModel else {
            return
        }
        
        nameLabeL.text = viewModel.name
        addressLabeL.text = viewModel.address
    }
    
}
