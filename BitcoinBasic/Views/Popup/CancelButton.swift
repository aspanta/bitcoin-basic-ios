//
//  CancelButton.swift
//  EmercoinBasic
//

import UIKit

class CancelButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        round(corners: [.bottomRight,.topRight], radius: 15)
    }

}
