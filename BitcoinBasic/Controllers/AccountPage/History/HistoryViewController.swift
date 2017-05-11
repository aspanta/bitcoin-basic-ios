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
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.handleRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    internal func handleRefresh(sender:UIRefreshControl) {
        history.load(loadAll: true)
    }
    
    private func setupHistory() {
        
        history.success.subscribe(onNext:{ [weak self] success in
            if success {
                self?.updateUI()
                self?.tableView.reload()
            }
        })
        .addDisposableTo(disposeBag)
        
        history.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
        .addDisposableTo(disposeBag)
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
        .addDisposableTo(disposeBag)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "History")
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
}
