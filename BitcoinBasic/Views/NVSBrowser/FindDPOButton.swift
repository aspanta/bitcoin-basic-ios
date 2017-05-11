//
//  FindDPOButton.swift
//  EmercoinBasic
//

import UIKit

class FindDPOButton: BaseButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fullyRound(diameter: frame.size.height, borderColor: .clear, borderWidth: 0)
    }

}
