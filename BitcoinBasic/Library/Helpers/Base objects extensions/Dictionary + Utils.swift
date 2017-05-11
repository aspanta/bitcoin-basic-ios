//
//  Dictionary + Utils.swift
//  VKApp
//

import UIKit

extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            
            let key = (key as! String)
            var resultValue:String = ""
            if let value = (value as? String) {
                resultValue = value
            } else if let value = (value as? NSNumber) {
                resultValue = value.stringValue
            }
            
            resultValue = resultValue.replacingOccurrences(of: " ", with: "")
            
            return "\(key)=\(resultValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
}
