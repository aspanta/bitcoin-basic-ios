//
//  PopupView.swift
//  EmercoinBasic
//

import UIKit

class PopupView: UIView {

    var cancel:((Void) -> (Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    @IBAction func doneButtonPressed(sender:UIButton?) {
        self.removeFromSuperview()
    }
    
    @IBAction func cancelButtonPressed(sender:UIButton?) {
        
        if cancel != nil {
            cancel!()
        }

        self.removeFromSuperview()
    }
}
