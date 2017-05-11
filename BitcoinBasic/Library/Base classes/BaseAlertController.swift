//
//  BaseAlertController.swift
//  EmercoinBasic
//

import UIKit

class BaseAlertController: UIAlertController {

    var done:((Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        if done != nil {
            done!()
            done = nil
        }
        print("deinit - BaseAlertController")
    }

}
