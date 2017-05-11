//
//  RoundButton.swift
//  EmercoinBasic
//

import UIKit

class RoundButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fullyRound(diameter: frame.size.height, borderColor: .clear, borderWidth: 0)
    }

}
