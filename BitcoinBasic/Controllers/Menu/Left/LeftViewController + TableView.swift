//
//  LeftViewController + TableView.swift
//  EmercoinBasic
//

import UIKit

extension LeftViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let cellIdentifier = row == 4 ? "MenuBCToolsCell" : "MenuDefaultCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BaseTableViewCell
        cell.object = itemAt(indexPath: indexPath)
        
        if row == 4 {
            let subCell = cell as! MenuDefaultCell
            subCell.pressedSubMenu = {[weak self] index in
                if self?.pressed != nil {
                    self?.pressed!(indexPath.row, index)
                }
            }
        }
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        
        if pressed != nil {
            pressed!(index,-1)
        }
    }
    
    private func itemAt(indexPath:IndexPath) -> MenuItem {
        return menuItems[indexPath.row]
    }
}
