//
//  BaseNavigationController.swift
//  EmercoinBasic
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isHidden = true
    }
}
