//
//  SideMenuViewController.swift
//  EmercoinBasic
//

import UIKit
import LGSideMenuController

class SideMenuViewController: LGSideMenuController {
    
    var swipeRange = LGSideMenuSwipeGestureRangeMake(100.0, 100.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        AppManager.sharedInstance.wallet.loadInfo()
    }
    
    fileprivate var mainTabBarController:TabBarController = {
        TabBarController.controller()
    }() as! TabBarController
    
    func hideTabBar(hiden:Bool) {
        mainTabBarController.tabBar.isHidden = hiden
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMenu()
    }
    
    deinit {
        print("deinit - SideMenuViewController")
    }
    
    private func setupMenu() {
        
        let menu = LeftViewController.controller() as! LeftViewController
        rootViewController = mainTabBarController
        
        menu.pressed = {[weak self](index,subIndex) in
            self?.selectTabItem(at: index,subIndex: subIndex)
        }
        
        menu.width = self.leftViewWidth
        
        leftViewController = menu
        
        Router.sharedInstance.sideMenu = self
    }
    
    func enableMenuSwipe(at state:Bool) {
        if state {
            leftViewSwipeGestureRange = swipeRange
        } else {
            leftViewSwipeGestureRange = LGSideMenuSwipeGestureRangeMake(0.0, 0.0)
        }
    }
    
    func showSendController(at data:AnyObject) {
        mainTabBarController.showController(at: data, index: 1)
    }
    
    func showGetCoinsController(at data:AnyObject) {
        mainTabBarController.showController(at: data, index: 2)
    }
    
    func showDashBoard() {
        
        changeRootController(to: self.mainTabBarController)
        
        //selectTabItem(at: 0, subIndex:0)
    }
    
    private func selectTabItem(at index:Int, subIndex:Int) {
        
        if index == 8 {
            logout()
        } else if index == 4 && subIndex != -1 {
            checkRootController()
            mainTabBarController.showNVSBrowser(at: index, subIndex: subIndex)
        } else if index > 4 {
            showController(at: index, subIndex: subIndex)
        } else {
            checkRootController()
            mainTabBarController.showController(at: index)
        }
        
        DispatchQueue.main.async {
            
            self.hideLeftView(animated: true)
        }
    }
    
    private func checkRootController() {
        
        if rootViewController != mainTabBarController {
            self.changeRootController(to: self.mainTabBarController)
        }
    }
    
    private func showController(at index:Int, subIndex:Int) {
        
        var vc:UIViewController?
        
        switch index {
        case 5:
            let bookVC = AddressBookViewController.controller() as! AddressBookViewController
            bookVC.isFromMenu = true
            vc = bookVC
        case 6:vc = AboutViewController.controller()
        case 7:vc = LicensiesViewController.controller()
        default:
            return
        }
        
        changeRootController(to: vc!)
    }
    
    private func changeRootController(to controller:UIViewController)  {
        
        self.rootViewController = controller
    }
    
    func logout() {
        AppManager.sharedInstance.logOut()
    }
}

extension UIViewController {
    
    @IBAction func backToDashBoard() {
        
        Router.sharedInstance.sideMenu?.showDashBoard()
    }
}
