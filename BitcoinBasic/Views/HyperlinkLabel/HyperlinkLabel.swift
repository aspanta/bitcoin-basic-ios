//
//  HyperlinkLabel.swift
//  EmercoinBasic
//


import UIKit

class HyperlinkLabel: UILabel {
    
    var textRange:NSRange?

    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            self.textRange = textRange
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: textRange)
            attributedText.addAttribute(NSLinkAttributeName, value: text, range: textRange)
            
            self.attributedText = attributedText
        }
    }
}
