//
//  TabBarController.swift
//  EmercoinBasic
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        addControllers()
    }
    
    var subControllerIndex = -1
    
    private func setupUI() {
        
        tabBar.tintColor = UIColor(hexString: Constants.Colors.TabBar.Tint)
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSFontAttributeName:UIFont(name: "RobotoCondensed-Bold", size: 10)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        
    }
    
    func showController(at index:Int) {
        
        checkChildControllers(at: index)
        selectedIndex = index
    }
    
    func showController(at data:AnyObject, index:Int) {
        
        checkChildControllers(at: index)
        
        guard let nav = viewControllers?[index] as? BaseNavigationController else {
            return
        }
        
        guard let controller = nav.viewControllers.first as? CoinOperationsViewController else {
            return
        }
        
        if index == 1 {
            controller.showSendController(at: data)
        } else if index == 2 {
            controller.showGetCoinsController(at: data)
        }
        
        selectedIndex = index
    }
    
    private func checkChildControllers(at index:Int) {
        
        guard let nav = viewControllers?[index] as? BaseNavigationController else {
            return
        }
        
        if nav.viewControllers.count > 1 {
            nav.popToRootViewController(animated: false)
        }
    }
    
    internal override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.description)
        
        guard let index = tabBar.items?.index(of: item) else {
            return
        }
        
        checkChildControllers(at: index)
    }
    
    private func addControllers() {
        
        let home = HomeViewController.controller() as! BaseViewController
        let homeNav = BaseNavigationController(rootViewController: home)
        let send = CoinOperationsViewController.controller() as! CoinOperationsViewController
        let sendNav = BaseNavigationController(rootViewController: send)
        let get = CoinOperationsViewController.controller() as! CoinOperationsViewController
        let getNav = BaseNavigationController(rootViewController: get)
        let history = CoinOperationsViewController.controller() as! CoinOperationsViewController
        let historyNav = BaseNavigationController(rootViewController: history)
        
        send.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Send,
                                        imageName: Constants.Controllers.TabImage.Send)
        send.coinsOperation = .recipientAddress
        
        get.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Get,
                                         imageName: Constants.Controllers.TabImage.Get)
        get.coinsOperation = .get
        
        history.tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.History,
                                            imageName: Constants.Controllers.TabImage.History)
        history.coinsOperation = .history

        viewControllers = [homeNav,sendNav,getNav,historyNav]
        
        let count:Int = (viewControllers?.count)!
        
        for index in 0...count - 1 {
            
            let tabHome = tabBar.items?[index]
            
            let navVC = viewControllers?[index] as! UINavigationController
            guard let vc = navVC.viewControllers.first as? TabBarObjectInfo else {
                break
            }
            
            if let item = vc.tabBarObject {
                tabHome?.title = item.title
                tabHome?.image = UIImage(named:item.imageName)
            }
        }
    }

}
