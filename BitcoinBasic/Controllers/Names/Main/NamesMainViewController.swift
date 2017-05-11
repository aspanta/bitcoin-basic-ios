//
//  NamesMainViewController.swift
//  EmercoinBasic
//

import UIKit

class NamesMainViewController: ButtonBarPagerTabStripViewController {

    let mainColor:UIColor = UIColor(hexString: Constants.Controllers.Send.HeaderView.EmercoinColor)
    let backgroundColor = UIColor(hexString: "#EAEAEA")
    
    var createPressed: ((_ data:Any) -> (Void))?
    
    private var recordsController:MyRecordsViewController?
    private var searchController:SearchNVSViewController?
    
    private var data:Any?
    private var isHasData = false
    
    override class func storyboardName() -> String {
        return "Names"
    }
    
    override func viewDidLoad() {
        
        setupUI()
        
        super.viewDidLoad()
    }
    
    private func setupUI() {
        
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
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let firstVC = MyRecordsViewController.controller() as! MyRecordsViewController
        let secondVC = SearchNVSViewController.controller() as! SearchNVSViewController
        secondVC.createPressed = {[weak self] data in
            
            if self?.createPressed != nil {
                self?.createPressed!(data)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                self?.moveTo(viewController: firstVC)
            }
        }
        
        recordsController = firstVC
        searchController = secondVC
        
        return [firstVC, secondVC]
    }
    
    
    func showSearchTab() {
        
        if self.buttonBarView.selectedIndex == 0 {
            self.moveTo(viewController: self.searchController!)
        }
        
    }
    
    func showMyNVSTab() {
        
        if self.buttonBarView.selectedIndex == 1 {
            self.moveTo(viewController: self.recordsController!)
        }
    }
    
    func addRecord(record:Record) {
        self.recordsController?.addRecord(record: record)
    }
    
    func reloadRecords() {
        self.recordsController?.records.load()
    }
}
