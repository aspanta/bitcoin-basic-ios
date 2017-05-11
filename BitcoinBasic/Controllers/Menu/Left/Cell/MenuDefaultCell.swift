//
//  MenuDefaultCell.swift
//  EmercoinBasic
//

import UIKit

class MenuDefaultCell: BaseTableViewCell {
    
    @IBOutlet internal weak var titleLabel:UILabel!
    @IBOutlet internal weak var iconView:UIImageView!
    
    var pressedSubMenu:((_ index:Int) -> (Void))?

    override func updateUI() {
        
        guard let menuItem = object as? MenuItem else {
            return
        }
        
        titleLabel.text = menuItem.title
        iconView.image = UIImage(named: menuItem.image)
        
    }

}
