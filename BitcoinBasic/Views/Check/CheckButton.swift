//
//  CheckButton.swift
//  EmercoinBasic
//

import UIKit

class CheckButton: UIButton {
    
    var isChecked:Bool = false {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        let image = isChecked ? "check_on" : "check_off"
        setImage(UIImage(named: image), for: .normal)
    }
}
