//
//  DetailValueView.swift
//  EmercoinOne
//

import UIKit

class DetailValueView: NVSValueView {

    @IBOutlet internal weak var valueScrollView:UIScrollView!
    @IBOutlet internal weak var valueLabel:UILabel!
    @IBOutlet internal weak var valueButton:UIButton!
    
    @IBInspectable var enableCopy:Bool = false
    
    var copyPressed:((Void) -> (Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        valueButton.addTarget(self, action:#selector(self.copyHandler), for: UIControlEvents.touchUpInside)
    }
    
    var value:String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if let value = value {
            valueLabel.text = value
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.valueScrollView.flashScrollIndicators()
            }
        }
    }
    
    func copyHandler() {
        if enableCopy && copyPressed != nil {
            copyPressed!()
        }
    }
}
