//
//  BaseCoinsOperationViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

enum CoinsOperation {
    case recipientAddress
    case send
    case get
    case historyAndOperations
    case myAddress
    case history
}

enum Side:Int{
    case left
    case right
}

class CoinOperationsViewController: BaseViewController {
    
    @IBOutlet internal weak var headerView:CoinOperationsHeaderView!
    @IBOutlet internal weak var operationLabel:UILabel!
    @IBOutlet internal weak var menuButton:UIButton!
    @IBOutlet internal weak var backButton:UIButton!
    @IBOutlet internal weak var addButton:UIButton!
    @IBOutlet internal weak var lockButton:LockButton!
    
    @IBOutlet internal weak var operationConstraint:NSLayoutConstraint!
    
    @IBOutlet internal weak var container:UIView!
    
    var coinsOperation:CoinsOperation = .recipientAddress
    let viewModel = CoinOperationsViewModel()
    let disposeBag = DisposeBag()
    
    var childController:UIViewController?
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareChildController()
    }
    
    override func setupUI() {
        super.setupUI()
        
        var text = ""
        
        var isMenuHide = false
        
        var count = 0
        
        if let countVC =  navigationController?.viewControllers.count {
            count = countVC
        }
        
        switch coinsOperation {
        case .recipientAddress:
            text = Constants.Controllers.CoinsOperation.RecipientAddress
            isMenuHide = count > 1
        case .get:
            text = Constants.Controllers.CoinsOperation.Get
            isMenuHide = count > 1
        case .send:
            text = Constants.Controllers.CoinsOperation.Send
            isMenuHide = true
        case .historyAndOperations: operationConstraint.constant = 0.0
            isMenuHide = true
        case .myAddress:
            text = Constants.Controllers.CoinsOperation.MyAddress
            isMenuHide = true
            addButton.isHidden = false
        case .history:
            text = Constants.Controllers.CoinsOperation.History
        }
        
        menuButton.isHidden = isMenuHide
        backButton.isHidden = !isMenuHide
        
        operationLabel.text = text
        
        viewModel.coinCourseTitle.bind(to: headerView.coinCourseLabel.rx.attributedText)
            .addDisposableTo(disposeBag)
        viewModel.coinAmount.bind(to: headerView.coinAmountLabel.rx.text)
            .addDisposableTo(disposeBag)
        viewModel.locked.subscribe(onNext: {[weak self] (locked) in
            self?.lockButton.isLocked = locked
        })
        .addDisposableTo(disposeBag)
        
        viewModel.updateUI()
        
    }
    
    func showSendController(at data:AnyObject) {
        
        if let controller = childController as? RecipientAddressViewController {
            controller.showSendController(at: data as? [String : Any])
        } else {
            object = data
        }
    }
    
    func showGetCoinsController(at data:AnyObject) {
        
        if let controller = childController as? GetCoinsViewController {
            controller.object = data
        } else {
            object = data
        }
    }
    
    private func prepareChildController() {
        
        var controller:UIViewController? = nil
        
        switch coinsOperation {
        case .recipientAddress:
            let vc = RecipientAddressViewController.controller() as! RecipientAddressViewController
            vc.object = object
            controller = vc
        case .send:
            let vc = SendCoinsViewController.controller() as! SendCoinsViewController
            vc.object = object
            controller = vc
        case .get:
            let vc = GetCoinsViewController.controller() as! GetCoinsViewController
            controller = vc
            vc.object = object
        case .historyAndOperations:
            let vc = AccountPageViewController.controller() as! AccountPageViewController
            controller = vc
        case .myAddress:
            let vc = MyAdressViewController.controller() as! MyAdressViewController
            controller = vc
        case .history:
            let vc = HistoryViewController.controller() as! HistoryViewController
            controller = vc
        }
        
        if controller != nil {
            addChildViewController(controller!)
            controller?.view.frame.size = container.frame.size
            container.addSubview((controller?.view)!)
            didMove(toParentViewController: controller!)
            self.childController = controller
        }
    }
    
    @IBAction internal func addButtonPressed(sender:UIButton) {
        if childController is MyAdressViewController {
            let controller = childController as! MyAdressViewController
            controller.showAddAddressView()
        }
    }
}
