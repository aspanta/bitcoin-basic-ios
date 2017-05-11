//
//  LoginButton.swift
//  EmercoinBasic
//

import UIKit

class LoginButton: BaseButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fullyRound(diameter: 8, borderColor: .clear, borderWidth: 0)
    }
}
