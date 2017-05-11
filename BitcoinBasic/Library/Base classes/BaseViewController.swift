//
//  BaseViewController.swift
//  EmercoinBasic
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate, TabBarObjectInfo {
    
    internal var activiryIndicator:UIActivityIndicatorView?
    
    var tabBarObject: TabBarObject?
    
    internal weak var statusBarView:UIView?
    
    var object:AnyObject?
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    deinit {
        
        if Constants.Permissions.PrintDeinit {
            print("deinit - "+String(describing: self))
        }
    }
    
    func setupUI() {
        addStatusBarView(color: UIColor.init(hexString: Constants.Colors.Status.Main))
    }
    
    func hideNavBar(state:Bool) {
        navigationController?.navigationBar.isHidden = state
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func menuShow() {
        
        Router.sharedInstance.sideMenu?.showLeftView(animated: true, completionHandler: {
            
        })
    }
    
    @IBAction func menuHide() {
        
        Router.sharedInstance.sideMenu?.hideLeftView(animated: true, completionHandler: {
            
        })
    }
    
    @IBAction func back() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideStatusBar() {
        statusBarView?.isHidden = true
    }
    
    func addStatusBarView(color:UIColor? = nil) {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        let color = color ?? UIColor(hexString: Constants.Colors.Status.Main)
        view.backgroundColor = color
        
        if statusBarView != nil {
            statusBarView?.backgroundColor = color
            statusBarView?.isHidden = false
        } else {
            statusBarView = view
            self.view.addSubview(view)
        }
    }
    
    @IBAction internal func lockButtonPressed() {
        
        let protectionHelper = WalletProtectionHelper()
        protectionHelper.fromController = self
        protectionHelper.startProtection()
    }
}
