//
//  BaseViewController + ActivityIndicator.swift
//  Emercoin Basic
//

import UIKit

extension BaseViewController {
    
    internal func createActivityIndicator() {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.color = UIColor(hexString: Constants.Colors.Status.Emercoin)
        indicator.center = view.center
        activiryIndicator = indicator
    }
    
    func showActivityIndicator() {
        
        if activiryIndicator == nil {
            createActivityIndicator()
        }
        
        if Thread.isMainThread {
            startAnimatingActivity()
        } else {
            
            DispatchQueue.main.async {
                self.startAnimatingActivity()
            }
        }
    }
    
    private func startAnimatingActivity() {
        
        activiryIndicator?.startAnimating()
        view.addSubview(activiryIndicator!)
    }
    
    func hideActivityIndicator() {
        
        if Thread.isMainThread {
            stopAnimatingActivity()
        } else {
            
            DispatchQueue.main.async {
                self.stopAnimatingActivity()
            }
        }
    }
    
    private func stopAnimatingActivity() {
        activiryIndicator?.removeFromSuperview()
        activiryIndicator?.stopAnimating()
    }
}
