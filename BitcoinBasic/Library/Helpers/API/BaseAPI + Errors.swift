//
//  BaseAPI + Errors.swift
//  EmercoinBasic
//

import Foundation

let removeStrings = [".", "Error: "]

extension BaseAPI {
    
    func formattedError(at error:Error) -> NSError {
        
        var text = ""
        
        let tempError = error as NSError
        
        let message = tempError.domain
        
        if message.contains("Unauthorized") {
            text = "Authentication failed"
        } else if message.contains("Insufficient funds") {
            text = "Insufficient funds"
        } else if message.contains("Could not connect") || message.contains("NSURLErrorDomain") {
            text = "Could not connect to the server"
        } else {
            
            for string in removeStrings {
                text = message.replacingOccurrences(of: string, with: "")
            }

        }
    
        let newError = NSError(domain: text, code: -1, userInfo: nil)
        
        return newError
    }
    
}
