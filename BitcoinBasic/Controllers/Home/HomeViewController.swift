//
//  HomeViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var lockButton:LockButton!
    
    var viewModel = CoinOperationsViewModel()
    let disposeBag = DisposeBag()
    
    internal var selectedRows:[IndexPath] = []
    internal var coins:[Any] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarObject = TabBarObject(title: Constants.Controllers.TabTitle.Home,
                                         imageName: Constants.Controllers.TabImage.Home)
    }
    
    override class func storyboardName() -> String {
        return "Home"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let wallet = viewModel.wallet {
            let coin = wallet.bitcoin
            coins = [coin]
        }
        setupTableView()
        setupRefreshControl()
        setupHome()
    }
    
    private func setupHome() {
        
        viewModel.error.subscribe(onNext: {[weak self] (error) in
            self?.showErrorAlert(at: error)
        })
        .disposed(by: disposeBag)
        
        viewModel.locked.subscribe(onNext: {[weak self] (locked) in
            self?.lockButton.isLocked = locked
        })
        .disposed(by: disposeBag)
        
        viewModel.walletSuccess.subscribe(onNext: {[weak self] (state) in
            self?.tableView.reload()
        })
        .disposed(by: disposeBag)
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        
        selectedRows.append(IndexPath(row: 0, section: 0))
        
        tableView.hideEmtyCells()
        tableView.allowsSelection = false
    }
    
    private func setupRefreshControl() {
        
        let refresh = tableView.setupRefresh()
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
    
        viewModel.activityIndicator.subscribe(onNext:{ [weak self] state in
            
            if state == false {
                refresh.endRefreshing()
            }
        })
        .disposed(by: disposeBag)
    }
    
    @objc internal func handleRefresh(sender:UIRefreshControl) {
        viewModel.updateWallet()
    }
}
