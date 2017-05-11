//
//  FeedbackMessageView.swift
//  EmercoinBasic
//

import UIKit

class FeedbackMessageView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        
        fullyRound(diameter: 10, borderColor: .lightGray, borderWidth: 1.0)
    }

}
