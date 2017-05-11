//
//  NoteShortInfoView.swift
//  EmercoinBasic
//

import UIKit

class RecordShortInfoView: PopupView {

    @IBOutlet internal weak var infoLabel:UILabel!
    
    var viewModel:RecordViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        if let viewModel = viewModel {
            let text = String(format:"Address %@ was create %@ %@",viewModel.name,
                              viewModel.expiresInDay,viewModel.expiresType)
            infoLabel.text = text
        }
    }
}
