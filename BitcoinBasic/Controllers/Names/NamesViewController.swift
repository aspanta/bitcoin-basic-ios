//
//  NamesViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

enum SubController {
    case main
    case searchResults
    case createNVS
    case myAddresses
    case recipientAddress
    case addresses
}

class NamesViewController: BaseViewController {
    
    var subController:SubController = .main
    var childController:UIViewController?
    
    @IBOutlet internal weak var container:UIView!
    @IBOutlet internal weak var mainTitleLabel:UILabel!
    @IBOutlet internal weak var mainTitleConstraint:NSLayoutConstraint!
    @IBOutlet internal weak var headerView:CoinOperationsHeaderView!
    @IBOutlet internal weak var menuButton:UIButton!
    @IBOutlet internal weak var backButton:UIButton!
    @IBOutlet internal weak var addButton:UIButton!
    @IBOutlet internal weak var lockButton:LockButton!
    
    private var data:Any?
    private var isHasData = false
    
    var records:Records?
    var createPressed: ((_ data:Any) -> (Void))?
    var created:((Void) -> (Void))?
    var edited:((_ data:[String:Any]) -> (Void))?
    var cancel:((Void) -> (Void))?
    var selectedAddress:((_ address:String) -> (Void))?
    
    var viewDidAppear: ((Void) -> (Void))?
    
    let viewModel = CoinOperationsViewModel()
    let disposeBag = DisposeBag()
    
    var isEditingMode = false
    var record:Record?
    
    override class func storyboardName() -> String {
        return "Names"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareChildController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewDidAppear != nil {
            viewDidAppear!()
        }
        
        if isHasData && subController == .main {
            isHasData = false
            showCreateNVSController(at: data)
        }
    }
    
    deinit {
        
        if Constants.Permissions.PrintDeinit {
            print("deinit - "+String(describing: self))
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        var text = ""
        
        var isMenuHide = true
        
        switch subController {
        case .main:
            isMenuHide = false
            mainTitleConstraint.constant = 0.0
            addButton.isHidden = false
        case .searchResults:
            text = Constants.Controllers.Names.SearchResults
        case .createNVS:
            text = isEditingMode ? Constants.Controllers.Names.EditNVS : Constants.Controllers.Names.CreateNVS
        case .myAddresses:
            text = Constants.Controllers.Names.MyAddresses
        case .recipientAddress:
            text = Constants.Controllers.Names.RecipientAddress
        case .addresses:
            text = Constants.Controllers.Names.Addresses
        }
        
        menuButton.isHidden = isMenuHide
        backButton.isHidden = !isMenuHide
        
        mainTitleLabel.text = text
        
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
    
    func showNamesTab(at index:Int) {
        
        if subController == .main {
            if let controller = childController as? NamesMainViewController {
                
                if index == 0 {
                    controller.showMyNVSTab()
                } else if index == 1 {
                    controller.showSearchTab()
                }
            }
        }
    }
    
    @IBAction func addNoteButtonPressed() {
        showCreateNVSController(at:nil)
    }
    
    private func showCreateNVSController(at data:Any?) {
        
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .createNVS
        controller.data = data
        
        if subController == .main {
            if let main = childController as? NamesMainViewController {
                    controller.created = {[weak self] in
                            main.reloadRecords()
                    }
            }
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func prepareChildController() {
        
        var controller:UIViewController? = nil
        
        switch subController {
        case .main:
            let vc = NamesMainViewController.controller() as! NamesMainViewController
            vc.createPressed = {[weak self] data in
                self?.isHasData = true
                self?.data = data
            }
            controller = vc
            
        case .searchResults:
            let vc = SearchNVSResultsViewController.controller() as! SearchNVSResultsViewController
            //vc.searchText = searchText
            if let records = self.records {
                vc.records = records
            }
            vc.createPressed = createPressed
            controller = vc
            
        case .createNVS:
            let vc = CreateNVSViewController.controller() as! CreateNVSViewController
            vc.data = data
            vc.created = self.created
            vc.edited = self.edited
            vc.isEditingMode = isEditingMode
            vc.record = record
            vc.cancel = cancel
            controller = vc
            
        case .myAddresses:
            let vc = AddressesNVSViewController.controller() as! AddressesNVSViewController
            vc.selectedAddress = self.selectedAddress
            controller = vc
        case .recipientAddress:
            let vc = RecipientAddressNVSViewController.controller() as! RecipientAddressNVSViewController
            vc.selectedAddress = self.selectedAddress
            controller = vc
        case .addresses:
            let vc = AddressesNVSViewController.controller() as! AddressesNVSViewController
            vc.isMyAddressBook = false
            vc.selectedAddress = self.selectedAddress
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
    
    override func back() {
        if cancel != nil {
            cancel!()
        }
        
        super.back()
        
    }
}
