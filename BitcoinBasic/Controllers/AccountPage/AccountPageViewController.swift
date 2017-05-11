//
//  AccountPageViewController.swift
//  EmercoinBasic
//

import UIKit

class AccountPageViewController: ButtonBarPagerTabStripViewController {
    
    let emerColor = Constants.Controllers.Send.HeaderView.EmercoinColor
    var mainColor:UIColor = UIColor(hexString: Constants.Controllers.Send.HeaderView.EmercoinColor)

    let backgroundColor = UIColor(hexString: "#EAEAEA")
    
    override class func storyboardName() -> String {
        return "AccountPage"
    }
    
    override func viewDidLoad() {
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = backgroundColor
        settings.style.buttonBarItemBackgroundColor = backgroundColor
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.buttonBarItemFont = UIFont(name: "Roboto-Regular", size: 18)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarHeight = 57.0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = self?.mainColor
        }
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let firstVC = OperationsViewController.controller() as! OperationsViewController
        let secondVC = HistoryViewController.controller() as! HistoryViewController

        return [firstVC, secondVC]
    }

}
