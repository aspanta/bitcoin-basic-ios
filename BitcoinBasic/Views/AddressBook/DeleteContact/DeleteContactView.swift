//
//  DeleteContact.swift
//  EmercoinBasic
//

import UIKit

class DeleteContactView: PopupView {

    var delete:((Void) -> (Void))?
    
    @IBAction override func doneButtonPressed(sender:UIButton?) {
        if delete != nil {
            delete!()
        }
        super.doneButtonPressed(sender: sender)
    }

}
