//
//  BaseTextView.swift
//  EmercoinBasic
//

import UIKit

class BaseTextView: UITextView, UITextViewDelegate {


    var textChanged:((_ text:String) -> (Void))?
    
    override func awakeFromNib() {
        
        delegate = self
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        
        if self.textChanged != nil {
            self.textChanged!((self.text)!)
        }
    }
}
