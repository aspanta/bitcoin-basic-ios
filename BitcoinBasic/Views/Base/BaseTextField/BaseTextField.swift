//
//  BaseTextField.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class BaseTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable var maxCharacters: Int = 0
    @IBInspectable var maxIntCharacters: Int = 0
    @IBInspectable var disableEdit: Bool = false
    @IBInspectable var validAmount: Bool = false

    var done:((_ text:String) -> (Void))?
    var textChanged:((_ text:String) -> (Void))?
    var didFirstResponder:((_ state:Bool) -> (Void))?
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        delegate = self
        
        self.rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: {(_) in
                if self.textChanged != nil {
                    self.textChanged!((self.text)!)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .addDisposableTo(disposeBag)
    }
    
    override func becomeFirstResponder() -> Bool {
        
        if didFirstResponder != nil {
            didFirstResponder!(true)
        }
        
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        if done != nil {
            done!(self.text!)
        }
        if didFirstResponder != nil {
            didFirstResponder!(false)
        }
        return super.resignFirstResponder()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if disableEdit {
            return false
        }
        
        let text = textField.text!
        
        var fullText = text.insert(string, index: range.location)
        fullText = fullText.replacingOccurrences(of: ",", with: ".")
        
        if validAmount {
            if fullText.contains(".") {
                return fullText.validEnterAmount()
            } else {
                return maxIntCharacters == 0 ? true : fullText.length <= maxIntCharacters
            }
        } else {
            return maxCharacters == 0 ? true : fullText.length <= maxCharacters
        }
    }
    
}
