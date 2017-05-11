//
//  ExchangeEnterButtonView.swift
//  EmercoinBasic
//

import UIKit

class ExchangeEnterButtonView: UIView {
    
    var signIn:((_ state:Bool) -> (Void))?
    
    @IBOutlet internal weak var button:UIButton!
    @IBOutlet internal weak var titleLabel:UILabel!
    
    var isSignIn = false {
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
        
        let text = isSignIn ? "Sign Out" : "Sign In"
        
        let textColor:UIColor = isSignIn ? .white : UIColor(hexString: Constants.Colors.Coins.Emercoin)
        let bgColor:UIColor = !isSignIn ? .white : UIColor(hexString: Constants.Colors.Coins.Emercoin)
        titleLabel.text = text
        backgroundColor = bgColor
        titleLabel.textColor = textColor
    }
    
    @IBAction func signInButtonPressed() {
        
        isSignIn = !isSignIn
        if signIn != nil {
            signIn!(isSignIn)
        }
    }


}
