//
//  CreateNVSViewController + DropDown.swift
//  EmercoinBasic
//

import UIKit

extension CreateNVSViewController {
    
    internal func setupPrefixDropDown() {
        
        prefixDropDown = DropDown()
        prefixDropDown?.anchorView = prefixButton
        prefixDropDown?.direction = .bottom
        
        let dataSource = ["Any"] + Constants.Names.Prefixes
        
        prefixDropLabel.text = dataSource.first
        
        prefixDropDown?.dataSource = dataSource
        
        prefixDropDown?.selectionAction = { [unowned self] (index, item) in
            self.prefixDropLabel.text = item
            self.prefixLabel.text = index != 0 ? item+":" : ""
        }
        
        prefixDropDown?.bottomOffset = CGPoint(x: 0, y: prefixButton.bounds.height)
        
        setupDropDownUI()
        
    }
    
    internal func setupDropDownUI() {
        
        let height = 10
        
        let fontSize = 18
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = prefixDropLabel.textColor
        appearance.cellHeight = prefixButton.bounds.height + CGFloat(height)
        appearance.textFont = UIFont(name: "Roboto-Regular", size: CGFloat(fontSize))!
    }
}
