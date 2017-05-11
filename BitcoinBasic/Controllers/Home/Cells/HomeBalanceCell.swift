//
//  HomeMyMoneyCell.swift
//  EmercoinBasic
//

import UIKit

class HomeBalanceCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var arrowImageView:UIImageView!
    @IBOutlet weak var iconImageView:UIImageView!
    @IBOutlet weak var overlayView:UIView!
    
    var views:[MyMoneyView] = []
    
    var pressed: ((Void) -> (Void))?
    
    
    private func addClosureAt(moneyView:MyMoneyView) {
        moneyView.pressed = {(type) in
            if self.pressed != nil {
                self.pressed!(type)
            }
        }
    }
    
    override func updateUI() {
        
        if !isExpanded {
            return
        }
        
        if let coins = object as? [Coin] {
            
            if views.count == 0 {
                
                var point = CGPoint(x: 0, y: Constants.CellHeights.HomeBalanceCell.Collapsed)
                
                for coin in coins {
                    
                    if views.count > 0 {
                        let separator = UIView(frame:frame)
                        separator.frame.size.height = 1.0
                        separator.frame.origin.y = point.y
                        separator.backgroundColor = .lightGray
                        point.y += 1
                        addSubview(separator)
                    }
                    
                    let moneyView:MyMoneyView = loadViewFromXib(name: "Home", index: 0, frame: .zero) as! MyMoneyView
                    var newFrame = frame
                    newFrame.origin = point
                    newFrame.size.height = CGFloat(Constants.CellHeights.HomeBalanceCell.MoneyView)
                    moneyView.coin = coin
                    moneyView.frame = newFrame
                    addSubview(moneyView)
                    point.y += newFrame.height
                    
                    views.append(moneyView)
                    addClosureAt(moneyView: moneyView)
                }
            } else {
                for i in 0...views.count - 1  {
                    views[i].coin = coins[i]
                }
            }
        }
        
        updateCellHeader()
        
    }
    
    private func updateCellHeader() {
        
        let titleColor:UIColor = (isExpanded) ? UIColor(hexString: "#9C73B1"): .white
        titleLabel.textColor = titleColor
        
        let iconImage = (isExpanded) ? "wallet_icon_color" : "wallet_icon"
        iconImageView.image = UIImage.init(named: iconImage)
        
        let arrowImage = (isExpanded) ? "arrow_col_icon" : "arrow_exp_icon"
        arrowImageView.image = UIImage.init(named: arrowImage)
        
        overlayView.isHidden = !isExpanded
    }
    
    @IBAction func pressedButton(sender:UIButton) {
        
        isExpanded = !isExpanded
        updateCellHeader()
        if pressedCell != nil {
            pressedCell!(indexPath!)
        }
    }

}
