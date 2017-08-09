//
//  UITableView + Utils.swift
//  EmercoinBasic
//

import Foundation
import UIKit

extension UITableView {
    
    func baseSetup() {
        self.hideEmtyCells()
        self.enableAutolayout()
    }
    
    func setupRefresh() -> UIRefreshControl {
    
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor(hexString: Constants.Colors.Coins.Bitcoin)
        self.refreshControl = refresh
        return refresh
    }
    
    func hideEmtyCells() {
        tableFooterView = UIView()
    }
    
    func enableAutolayout() {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 66.0
    }
    
    func reload() {
        
        DispatchQueue.main.async() {
            self.reloadData()
        }
    }
    
    
}
