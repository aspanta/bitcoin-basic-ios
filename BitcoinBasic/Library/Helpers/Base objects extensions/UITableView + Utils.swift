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
