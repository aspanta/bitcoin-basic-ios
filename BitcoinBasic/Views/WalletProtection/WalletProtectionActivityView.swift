//
//  WalletProtectionActivityView.swift
//  EmercoinBasic
//

import UIKit

class WalletProtectionActivityView: PopupView {
    
    @IBOutlet weak var titleLabel:UILabel!

    var type:ProtectionViewType = .unlock {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUI()
    }
    
    func updateUI() {
        
        var text = ""
        
        switch type {
            case .lock:text = "Locking"
            case .unlock:text = "Unlocking"
            case .protection:text = "Encrypting"
        default:
            text = "Protection"
        }
        
        text = text + " wallet..."
        
        titleLabel.text = text
    }
    
    deinit {
        print("deinit - WalletProtectionActivityView")
        userInteraction(at: true)
    }
}
