//
//  LeftViewController.swift
//  EmercoinBasic
//

import UIKit

class LeftViewController: BaseViewController {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var versionLabel:UILabel!
    
    
    var menuItems:[MenuItem] = []
    
    var width:CGFloat = 0
    
    var pressed:((_ index:Int, _ subIndex:Int) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()

        addMenuItems()
        setupController()
        tableView.baseSetup()
    }
    
    override func setupUI() {
        super.setupUI()
        
        let version = bundleVersion()
        versionLabel.text = String(format:"Version %@",version)
    }
    
    private func setupController() {
        
        statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Menu)
        statusBarView?.frame.size.width = width
    }
    
    private func addMenuItems() {
        
        let homeMenuItem = MenuItem(title: Constants.Controllers.Menu.Home.Title,
                                        image: Constants.Controllers.Menu.Home.Image)
        let sendMenuItem = MenuItem(title: Constants.Controllers.Menu.Send.Title,
                                    image: Constants.Controllers.Menu.Send.Image)
        let getMenuItem = MenuItem(title: Constants.Controllers.Menu.Get.Title,
                                    image: Constants.Controllers.Menu.Get.Image)
        let bctoolsMenuItem = MenuItem(title: Constants.Controllers.Menu.BCTools.Title,
                                    image: Constants.Controllers.Menu.BCTools.Image)
        let aboutMenuItem = MenuItem(title: Constants.Controllers.Menu.About.Title,
                                    image: Constants.Controllers.Menu.About.Image)
        let legalMenuItem = MenuItem(title: Constants.Controllers.Menu.Legal.Title,
                                        image: Constants.Controllers.Menu.Legal.Image)
        let exitMenuItem = MenuItem(title: Constants.Controllers.Menu.Exit.Title,
                                    image: Constants.Controllers.Menu.Exit.Image)
        let historyMenuItem = MenuItem(title: Constants.Controllers.Menu.History.Title,
                                    image: Constants.Controllers.Menu.History.Image)
        let bookMenuItem = MenuItem(title: Constants.Controllers.Menu.Book.Title,
                                       image: Constants.Controllers.Menu.Book.Image)
        
        menuItems = [homeMenuItem,sendMenuItem,getMenuItem,historyMenuItem,bctoolsMenuItem,
                     bookMenuItem,aboutMenuItem,legalMenuItem,exitMenuItem]
        
    }

}
