//
//  FeedBackSendButton.swift
//  EmercoinBasic
//

import UIKit

class FeedBackSendButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fullyRound(diameter: frame.size.height, borderColor: .clear, borderWidth: 0)
    }
}
