//
//  ProtectionValidationView.swift
//  EmercoinBasic
//


import UIKit

class ProtectionValidationView: UIView {
    
    @IBOutlet internal weak var textView:BaseTextView!
    @IBOutlet internal weak var titleLabel:UILabel!
    @IBOutlet internal weak var nextButton:RoundButton!
    
    var nextPressed:((Void) -> (Void))?
    var startOverPressed:((Void) -> (Void))?
    var enterText:((_ text:String) -> (Void))?
    
    var isValide:Bool = false {
        didSet{
            nextButton.isEnabled = isValide
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.textChanged = {text in
            
            self.titleLabel.isHidden = text.length > 0
            
            if self.enterText != nil {
                self.enterText!(text)
            }
        }
    }
    
    @IBAction func nextButtonPressed() {
        
        if nextPressed != nil {
            nextPressed!()
        }
    }
    
    @IBAction func startOverButtonPressed() {
        
        if startOverPressed != nil {
            startOverPressed!()
        }
    }

}
