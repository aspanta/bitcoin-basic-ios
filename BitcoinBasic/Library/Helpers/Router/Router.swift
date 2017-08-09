//
//  Router.swift
//  EmercoinBasic
//

import Foundation
import UIKit

class Router {
    
    internal static let sharedInstance = Router()
    internal var sideMenu:SideMenuViewController?
    
    private var isBlockchainLoadingControllerActive = false
    
    private func changeRootController(to viewController: UIViewController) {
        if let window = UIApplication.shared.delegate?.window {
            UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window?.rootViewController = viewController
            }, completion: nil)
        }
    }
    
    internal func showLoginController() {
        let login = controller(at: "login")
        changeRootController(to:login)
        sideMenu = nil
    }
    
    internal func showMainController() {
        let main = controller(at: "main")
        isBlockchainLoadingControllerActive = false
        changeRootController(to:main)
    }
    
    internal func showBlockChainLoadingController(at blocks:Int = 0) {
       if  let nav = controller(at: "blockchain") as? BaseNavigationController {
        if let vc = nav.viewControllers.first as? BlockchainLoadingViewController {
            vc.blocks = blocks
        }
        changeRootController(to:nav)
        isBlockchainLoadingControllerActive = true
        sideMenu = nil
       }
        
    }
    
    func initialController() -> UIViewController {
        
        var name = "login"
        
        if let authInfo = AppManager.sharedInstance.settings.authInfo {
            APIManager.sharedInstance.addAuthInfo(at: authInfo)
            name = "main"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.checkBlockchainLoading()
            }
        }
        
        return controller(at:name)
    }
    
    func checkBlockchainLoading() {
        
        if AppManager.sharedInstance.settings.authInfo != nil {
            APIManager.sharedInstance.loadBlockchainInfo{[weak self] (data, error) in
                if error != nil {
                } else {
                    if let blockchain = data as? Blockchain {
                        if blockchain.isLoaded == false {
                            if self?.isBlockchainLoadingControllerActive == false {
                                self?.showBlockChainLoadingController(at:blockchain.blocks)
                            }
                        }
                    }
        
                }
            }
        }
    }
    
    private func controller(at name:String) -> UIViewController {
        
        var controller = UIViewController()
        
        switch name {
        case "main":
            let main = UIStoryboard(name: "Main", bundle: nil)
            controller = main.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        case "login":controller = LoginViewController.controller()
        case "blockchain":controller = BlockchainLoadingViewController.controller()
        default:
            break
        }
        let nav = BaseNavigationController(rootViewController: controller)
        return nav
    }
    
}
