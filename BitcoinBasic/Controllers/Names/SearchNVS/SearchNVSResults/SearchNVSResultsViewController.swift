//
//  SearchNVSResultsViewController.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class SearchNVSResultsViewController: MyRecordsViewController {
    
    @IBOutlet internal var textLabel:UILabel!
    
    var createPressed: ((_ data:Any) -> (Void))?
    
    override class func storyboardName() -> String {
        return "Names"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = String(format:"Your query\n %@\n not found",records.searchString)
    }
    
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed() {
       // parent?.navigationController?.popViewController(animated: true)
        
        let data = nameData()
        
        if createPressed != nil {
            createPressed!(data)
        }
        parent?.navigationController?.popToRootViewController(animated: true)
    }
    
    override func nvsInfoButtonPressed() {
        let vc = NVSInfoViewController.controller() as! NVSInfoViewController
        vc.infoType = .why
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func nameData() -> [String:String] {
        var text = records.searchString
        let array = text.components(separatedBy: ":")
        let prefixes = Constants.Names.Prefixes
        
        var data = [String:String]()
        
        if array.count == 2 {
            let prefix = array.first ?? ""
            let name = array.last ?? ""
            
            if prefixes.contains(prefix) {
                data["prefix"] = prefix
                text = name
            }
        }
        
        data["name"] = text
        return data
    }
}
