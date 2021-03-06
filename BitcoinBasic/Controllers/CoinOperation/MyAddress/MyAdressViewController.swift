//
//  MyAdressViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa
import SwipeCellKit

class MyAdressViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {

    @IBOutlet internal weak var tableView:UITableView!
    
    var addressBook = AddressBook()
    var isMyAddressBook = true
    let disposeBag = DisposeBag()
    private var operationActivityView:UIView?
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isMyAddressBook {
            addressBook = AppManager.sharedInstance.myAddressBook
            setupAddresses()
            setupActivityIndicator()
            setupRefreshControl()
            addressBook.load()
        }
        
        tableView.baseSetup()
        hideStatusBar()
    }
    
    private func setupAddresses() {
        
        addressBook.success.subscribe(onNext:{ [weak self] success in
            if success {self?.tableView.reload()}
        })
            .disposed(by: disposeBag)
        
        addressBook.error.subscribe(onNext:{ [weak self] error in
            self?.hideOperationActivityView()
            self?.showErrorAlert(at: error)
        })
            .disposed(by: disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        addressBook.activityIndicator.subscribe(onNext:{ [weak self] state in
            
            let refresh = self?.tableView.refreshControl
            
            if state == false {
                if refresh?.isRefreshing == true  {
                    refresh?.endRefreshing()
                }
                self?.hideOperationActivityView()
            } else {
            }
        })
            .disposed(by: disposeBag)
    }
    
    private func setupRefreshControl() {
        
        let refresh = tableView.setupRefresh()
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
    }
    
    @objc internal func handleRefresh(sender:UIRefreshControl) {
        addressBook.load(loadAll: true)
    }

    func showAddAddressView() {
        
        let addAddressView = loadViewFromXib(name: "AddressBook", index: 2,
                                             frame: self.parent!.view.frame) as! AddAddressView
        addAddressView.add = ({[weak self] (name) in
            self?.addressBook.addNewMyAddress(at: name)
            self?.showOperationActivityView()
        })
        self.parent?.view.addSubview(addAddressView)
    }
    
    internal func didSelectItem(contact:Contact) {
        
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    private func showOperationActivityView() {
        
        var controller:UIViewController?
        
        if let parent = self.parent as? CoinOperationsViewController {
            controller = parent
        }
        
        if let controller = controller {
            let view = loadViewFromXib(name: "Send", index: 2,
                                       frame: controller.view.frame)
            self.operationActivityView = view
            userInteraction(at: false)
            controller.view.addSubview(view)
        }
    }
    
    private func hideOperationActivityView() {
        
        if let view = operationActivityView {
            userInteraction(at: true)
            view.removeFromSuperview()
        }
    }
}
