//
//  EncryptionButton.swift
//  EmercoinBasic
//


import UIKit

class EncryptionButtonView: UIView {
    
    var encryption:((_ on:Bool) -> (Void))?
    
    @IBOutlet internal weak var button:UIButton!
    @IBOutlet internal weak var titleLabel:UILabel!
    
    var isEncryptionOn = false {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        
        let color = UIColor(hexString: Constants.Colors.Coins.Emercoin)
        
        fullyRound(diameter: 44, borderColor: color, borderWidth: 1.0)
    }
    
    private func updateUI() {
        
        let text = isEncryptionOn ? "Change\nPassword" : "On"
        
        if isIphone5() {
            let font = UIFont(name: "Roboto-Regular", size: isEncryptionOn ? 14 : 18)!
            titleLabel.font = font
        }
        
        titleLabel.text = text
    }
    
    @IBAction func encryptionButtonPressed() {
        
        isEncryptionOn = !isEncryptionOn
        if encryption != nil {
            encryption!(isEncryptionOn)
        }
    }

}
