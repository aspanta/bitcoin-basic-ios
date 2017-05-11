
//
//  HistoryViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension HistoryViewController:UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = history.transactions.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HistoryCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        let viewModel = HistoryTransactionViewModel(historyTransaction: itemAt(indexPath: indexPath))
        cell.object = viewModel
        return cell
    }
    
    private func itemAt(indexPath:IndexPath) -> HistoryTransaction {
        return history.transactions[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
    }
}
