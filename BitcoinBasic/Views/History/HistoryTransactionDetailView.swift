//
//  HistoryTransactionDetailView.swift
//  EmercoinOne
//

import UIKit

class HistoryTransactionDetailView: PopupView {

    @IBOutlet internal weak var dataValueView:DetailValueView!
    @IBOutlet internal weak var addressValueView:DetailValueView!
    @IBOutlet internal weak var categoryValueView:DetailValueView!
    @IBOutlet internal weak var amountValueView:DetailValueView!
    @IBOutlet internal weak var feeValueView:DetailValueView!
    @IBOutlet internal weak var transactionIdValueView:DetailValueView!
    @IBOutlet internal weak var voutValueView:DetailValueView!
    @IBOutlet internal weak var blockheightValueView:DetailValueView!
    
    var repeatTransaction:(() -> (Void))?
    
    var viewModel:HistoryTransactionViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if let viewModel = viewModel {
        
            let sign = "BTC"
            
            dataValueView.value = viewModel.dateFull
            amountValueView.value = viewModel.amount + " \(sign)"
            categoryValueView.value = viewModel.category
            feeValueView.value = viewModel.fee + " \(sign)"
            voutValueView.value = viewModel.vout
            blockheightValueView.value = viewModel.blockhash
            blockheightValueView.enableCopy = viewModel.isConfirmed
            blockheightValueView.copyPressed = {[weak self] in
                self?.copyToBuffer(at: viewModel.blockhash)
            }

            let address = viewModel.address
            addressValueView.value = address
            addressValueView.copyPressed = {[weak self] in
                self?.copyToBuffer(at: address)
            }
            
            let transactionId = viewModel.transactionId
            transactionIdValueView.value = transactionId
            transactionIdValueView.copyPressed = {[weak self] in
                self?.copyToBuffer(at: transactionId)
            }
    
            
        }
    }
    
    private func copyToBuffer(at text:String) {
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
    
    @IBAction func repeatButtonPressed() {
        
        if repeatTransaction != nil {
            repeatTransaction!()
        }
        
        doneButtonPressed(sender: nil)
    }

}
