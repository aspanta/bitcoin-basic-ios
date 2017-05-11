//
//  BCNoteCell.swift
//  EmercoinBasic
//

import UIKit

class RecordCell: BaseTableViewCell {

    @IBOutlet weak var nameLabeL:UILabel!
    @IBOutlet weak var timeValue:UILabel!
    @IBOutlet weak var timeType:UILabel!
    
    @IBOutlet weak var timeValueConstraint:NSLayoutConstraint!
    
    override func updateUI() {
        
        guard let viewModel = object as? RecordViewModel else {
            return
        }
        
        nameLabeL.text = viewModel.name
        timeValue.text = viewModel.expiresInDay
        timeType.text = viewModel.expiresType
        
        timeValueConstraint.constant = CGFloat(viewModel.expiresInDay.length * 11)
    }

}
