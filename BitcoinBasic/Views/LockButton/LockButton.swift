//
//  LockButton.swift
//  EmercoinBasic
//

import UIKit

class LockButton: UIButton {
    
    var isLocked = false {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        
        let imageName = isLocked ? "lock_icon" : "unlock_icon"
        setImage(UIImage.init(named: imageName), for: .normal)
    }
}
