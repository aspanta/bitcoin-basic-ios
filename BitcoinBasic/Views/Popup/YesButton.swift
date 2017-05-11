//
//  YesButton.swift
//  EmercoinBasic
//

import UIKit

class YesButton: BaseButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        round(corners: [.bottomLeft,.topLeft], radius: 15)
    }

}
