
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
    
    internal func itemAt(indexPath:IndexPath) -> HistoryTransaction {
        return history.transactions[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndexPath = indexPath
        
        let cell = tableView.cellForRow(at: indexPath) as? BaseTableViewCell
        let item = cell?.object
        
        showTransactionDetailView(at:item as! HistoryTransactionViewModel)
    }
}
