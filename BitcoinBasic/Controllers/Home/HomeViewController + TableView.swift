//
//  HomeViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension HomeViewController {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = 0.0
        
        let isSelectedRow = selectedRows.contains(indexPath)
        
        switch indexPath.row {
        case 0:height = Constants.CellHeights.HomeBalanceCell.Collapsed
        if isSelectedRow {
            let coinsHeight = Constants.CellHeights.HomeBalanceCell.MoneyView * Double(coins.count)
            height += coinsHeight
            }
        default:break
        }
        
        return CGFloat(height)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HomeBalanceCell"
        
        let cell:BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        
        cell.indexPath = indexPath
        
        cell.pressedCell = {[weak self] (selIndexPath) in
            self?.expandedCell(indexPath: selIndexPath)
        }
        
        if indexPath.row == 0 {
            
             let moneyCell = cell as! HomeBalanceCell
            moneyCell.pressed = {[weak self] (type) in
                self?.showOperationController()
            }
            cell.isExpanded = selectedRows.contains(indexPath)
            cell.object = coins
        }
        
        return cell
    }
    
    private func showOperationController() {
    
        let controller = CoinOperationsViewController.controller() as! CoinOperationsViewController
        controller.coinsOperation = .historyAndOperations
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func expandedCell(indexPath:IndexPath) {
        
        if !selectedRows.contains(indexPath) {
            selectedRows.append(indexPath)
        } else {
            selectedRows.remove(object: indexPath)
        }
        
        tableView.reload()
    }
}
