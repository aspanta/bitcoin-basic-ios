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
            attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: textRange)
            attributedText.addAttribute(NSAttributedStringKey.link, value: text, range: textRange)
            
            self.attributedText = attributedText
        }
    }
}
