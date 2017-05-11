//
//  HistoryCell.swift
//  EmercoinBasic
//

import UIKit

class HistoryCell: BaseTableViewCell {

    @IBOutlet weak var dateLabeL:UILabel!
    @IBOutlet weak var addressLabeL:UILabel!
    @IBOutlet weak var amountLabeL:UILabel!
    @IBOutlet weak var signLabeL:UILabel!
    @IBOutlet weak var directionImageView:UIImageView!
    
    override func updateUI() {
        
        guard let viewModel = object as? HistoryTransactionViewModel else {
            return
        }
        
        dateLabeL.text = viewModel.date
        addressLabeL.text = viewModel.address
        amountLabeL.text = viewModel.amount
        signLabeL.text = viewModel.sign
        directionImageView.image = viewModel.imageTransactionDirection
    }
}
