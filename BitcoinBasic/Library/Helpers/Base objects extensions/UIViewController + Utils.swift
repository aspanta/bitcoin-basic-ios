//
//  UIViewController + Utils.swift
//  EmercoinBasic
//

import Foundation
import UIKit

extension UIViewController {
    
    func dissmisModal() {
        dismiss(animated: true, completion: nil)
    }
    
  class func controller() -> UIViewController {
        
        let storyboardName = self.storyboardName()
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let controllerIdentifier = String.init(describing: self)
        let controller = storyboard.instantiateViewController(withIdentifier: controllerIdentifier)
        return controller
    }
    
    @objc class func storyboardName() -> String {
        // override method for other storyboard names
        return "Main"
    }

}
