//
//  ExchangeHeaderView.swift
//  EmercoinBasic
//

import UIKit

class ExchangeHeaderView: UIView {
    
    let color = UIColor(hexString: "7FAEDA")

    @IBOutlet weak var dropListFirstView:UIView!
    @IBOutlet weak var dropListSecondView:UIView!
    
    @IBOutlet weak var dropHeadFirstLabel:UILabel!
    @IBOutlet weak var dropHeadSecondLabel:UILabel!

    var dropDownFirst:DropDown?
    var dropDownSecond:DropDown?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dropDownFirst = DropDown()
        dropDownSecond = DropDown()
        
        dropDownFirst?.anchorView = dropListFirstView
        dropDownSecond?.anchorView = dropListSecondView
        
        dropDownFirst?.dataSource = ["EMC", "BTC", "LTC", "DAS", "HEMC"]
        dropDownSecond?.dataSource = ["EMC", "BTC", "LTC", "DAS", "HEMC"]
        
        dropDownFirst?.selectionAction = { [unowned self] (index, item) in
            self.dropHeadFirstLabel.text = item
            self.dropListFirstView.backgroundColor = .clear
            self.dropHeadFirstLabel.textColor = .white
        }
        
        dropDownSecond?.selectionAction = { [unowned self] (index, item) in
            self.dropHeadSecondLabel.text = item
            self.dropListSecondView.backgroundColor = .clear
            self.dropHeadSecondLabel.textColor = .white
        }
        
        dropDownFirst?.bottomOffset = CGPoint(x: 0, y: dropListFirstView.bounds.height)
        dropDownSecond?.bottomOffset = CGPoint(x: 0, y: dropListSecondView.bounds.height)
        
        dropDownFirst?.cancelAction = { [unowned self] in
            print("Drop down dismissed")
            self.dropListFirstView.backgroundColor = .clear
            self.dropHeadFirstLabel.textColor = .white
        }
        
        dropDownFirst?.willShowAction = { [unowned self] in
            print("Drop down will show")
            self.dropListFirstView.backgroundColor = .white
            self.dropHeadFirstLabel.textColor = self.color
        }
        
        dropDownSecond?.cancelAction = { [unowned self] in
            print("Drop down dismissed")
            self.dropListSecondView.backgroundColor = .clear
            self.dropHeadSecondLabel.textColor = .white
        }
        
        dropDownSecond?.willShowAction = { [unowned self] in
            print("Drop down will show")
            self.dropListSecondView.backgroundColor = .white
            self.dropHeadSecondLabel.textColor = self.color
        }
        
        let appearance = DropDown.appearance()
        
        appearance.selectionBackgroundColor = color
        appearance.cellHeight = dropListFirstView.bounds.height + 5
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 17)!

    }
    
    @IBAction func showDropListFirst() {
        
        dropDownFirst?.show()
    }
    
    @IBAction func showDropListSecond() {
        
        dropDownSecond?.show()
    }

}
