//
//  AlertsHelper.swift
//  EmercoinBasic
//

import UIKit

class AlertsHelper {
    
    class func errorAlert(at error:NSError) -> BaseAlertController {
        
        let alert = BaseAlertController(
            title: "Error",
            message: String (format:error.domain),
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            
            if error.domain == "Authentication failed" && AppManager.sharedInstance.isAuthorized {
                Router.sharedInstance.sideMenu?.logout()
            }
            
        }))
        
        userInteraction(at: true)
        
        return alert
    }
    
}
