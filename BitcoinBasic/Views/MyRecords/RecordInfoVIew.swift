//
//  NoteInfoVIew.swift
//  EmercoinBasic
//

import UIKit

class RecordInfoVIew: PopupView {
    
    @IBOutlet internal weak var valueTextView:BaseTextView!
    @IBOutlet internal weak var addressLabel:UILabel!
    @IBOutlet internal weak var nameLabel:UILabel!
    @IBOutlet internal weak var expiresLabel:UILabel!
    @IBOutlet internal weak var nameScrollView:UIScrollView!
    @IBOutlet internal weak var addressScrollView:UIScrollView!
    @IBOutlet internal weak var nameButton:UIButton!
    @IBOutlet internal weak var valueButton:UIButton!
    @IBOutlet internal weak var addressButton:UIButton!
    @IBOutlet internal weak var valueScrollView:UIScrollView!
    @IBOutlet internal weak var valueView:UIView!
    @IBOutlet internal weak var valueLabel:UILabel!
    
    var viewModel:RecordViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if let viewModel = viewModel {
            
            let date = String(format:"%@ %@",viewModel.expiresInDay, viewModel.expiresType)
            let name = viewModel.name
            let value =  String.isInfoCardType(at: name) ? "<Infocard>" : viewModel.value
            let address = viewModel.address
    
            //nameTextView.text = name
            nameLabel.text = name
            
            valueLabel.text = value
            addressLabel.text = address
            expiresLabel.text = date
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.valueScrollView.flashScrollIndicators()
            self.nameScrollView.flashScrollIndicators()
            self.addressScrollView.flashScrollIndicators()
            
            let width = self.nameScrollView.frame.size.width
            
            self.nameButton.frame.size.width = width
            self.addressButton.frame.size.width = width
            self.valueButton.frame.size.width = width
            self.addressLabel.frame.size.width = width
            self.valueScrollView.contentSize.width = width
            self.valueView.frame.size.width = width
        }
    }
    
    @IBAction func copyButtonPressed(sender:UIButton) {
        
        var text = ""
        
        switch sender.tag {
        case 0:
            text = nameLabel.text ?? ""
        case 1:
            text = addressLabel.text ?? ""
        case 2:
            text = valueLabel.text ?? ""
        default:
            break
        }
        
        UIPasteboard.general.string = text
        showCopyView()
    }
    
    private func showCopyView() {
        
        let copyView:UIView = loadViewFromXib(name: "AddressBook", index: 3,
                                              frame: nil)
        copyView.alpha = 0;
        addSubview(copyView)
        
        copyView.center = center
        
        UIView.animate(withDuration: 0.3) {
            copyView.alpha = 0.8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3, animations: {
                copyView.alpha = 0.0
            }, completion: { (state) in
                copyView.removeFromSuperview()
            })
        }
    }
}
