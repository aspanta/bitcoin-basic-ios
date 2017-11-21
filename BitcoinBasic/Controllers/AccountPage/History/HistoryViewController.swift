//
//  HistoryViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet internal weak var tableView:UITableView!
    @IBOutlet internal weak var noTransactionsLabel:UILabel!
    
    var history = History()
    
    let disposeBag = DisposeBag()
    
    internal var selectedIndexPath:IndexPath?
    
    override class func storyboardName() -> String {
        return "AccountPage"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        history.load(loadAll:true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.baseSetup()
        setupHistory()
        updateUI()
        setupRefreshControl()
        setupActivityIndicator()
    
    }
    
    private func updateUI() {
        
        noTransactionsLabel.isHidden = history.transactions.count != 0
    }
    
    private func setupRefreshControl() {
        
        let refresh = tableView.setupRefresh()
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
    }
    
    @objc internal func handleRefresh(sender:UIRefreshControl) {
        history.load(loadAll: true)
    }
    
    private func setupHistory() {
        
        history.success.subscribe(onNext:{ [weak self] success in
            if success {
                self?.updateUI()
                self?.tableView.reload()
            }
        })
        .disposed(by: disposeBag)
        
        history.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
        .disposed(by: disposeBag)
    }
    
    private func setupActivityIndicator() {
        
        history.activityIndicator.subscribe(onNext:{ [weak self] state in
            
            let refresh = self?.tableView.refreshControl
            
            if state == false {
                if refresh?.isRefreshing == true  {
                    refresh?.endRefreshing()
                }
            }
        })
        .disposed(by: disposeBag)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "History")
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    internal func showTransactionDetailView(at viewModel:HistoryTransactionViewModel) {
        
        let transactionDetailView = loadViewFromXib(name: "History", index: 0,
                                                    frame: self.parent?.parent?.view.frame) as! HistoryTransactionDetailView
        transactionDetailView.viewModel = viewModel
        
        transactionDetailView.repeatTransaction = {[weak self] in
            self?.repeatTransaction()
        }
        
        self.parent?.parent?.view.addSubview(transactionDetailView)
        
    }
    
    private func repeatTransaction() {
        
        if let indexPath = selectedIndexPath {
            
            let item = itemAt(indexPath: indexPath)
            
            var data = [String:Any]()
            data["address"] = item.address as AnyObject
            data["amount"] = String.coinFormat(at: abs(item.amount)) as AnyObject
            
            let menu = Router.sharedInstance.sideMenu
            
            if item.direction() == .outcoming {
                menu?.showSendController(at: data as AnyObject)
            } else {
                menu?.showGetCoinsController(at: data as AnyObject)
            }
            
            selectedIndexPath = nil
        }
    }
}
