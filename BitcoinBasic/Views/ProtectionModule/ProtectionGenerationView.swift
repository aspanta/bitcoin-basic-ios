//
//  ProtectionGenerateWordView.swift
//  EmercoinBasic
//

import UIKit

class ProtectionGenerationView: UIView {
    
    @IBOutlet internal weak var nextButton:RoundButton!
    @IBOutlet internal weak var wordLabel:UILabel!
    @IBOutlet internal weak var countLabel:UILabel!
    
    var word:String? {
        didSet {
            wordLabel.text = word ?? ""
        }
    }
    
    var count:Int? {
        didSet {
            countLabel.text = String(format:"Word %i of 8", count ?? 1)
            
            if count == 8 {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    var nextPressed:((Void) -> (Void))?
    var startOverPressed:((Void) -> (Void))?
    
    @IBAction func nextButtonPressed() {
        
        if nextPressed != nil {
            nextPressed!()
        }
    }

    @IBAction func startOverButtonPressed() {
        
        nextButton.setTitle("Next word", for: .normal)
        
        if startOverPressed != nil {
            startOverPressed!()
        }
    }
}
