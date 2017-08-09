//
//  NVSValueView.swift
//  EmercoinOne
//

import UIKit

class NVSValueView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        
        fullyRound(diameter: 10, borderColor: UIColor(hexString: "CCCCCC"), borderWidth: 1.0)
    }
}
