//
//  QRCodeHelper.swift
//  EmercoinBasic
//

import UIKit
import QRCode

class QRCodeHelper {
    
    class func parseScanedText(result:String, completion:@escaping (_ data: AnyObject?,_ success:Bool?) -> Void) {
        
        var coin:[String:Any] = [:]
        
        var isSuccess = false
        
        let array = result.components(separatedBy: "?")
        
        if array.count > 1 {
            
            var amountArray = array[1].components(separatedBy:"&").filter({ (string) -> Bool in
                return string.contains("amount")
            })
            
            if amountArray.count == 1 {
                amountArray = amountArray[0].components(separatedBy: "=")
                
                if amountArray.count == 2 {
                    let amount = amountArray[0].lowercased()
                    if amount == "amount" {
                        coin["amount"] = amountArray[1].replacingOccurrences(of: ",", with: ".")
                    }
                }
            }
        }
        
        let coinArray = array[0].components(separatedBy: ":")
        
        if coinArray.count == 2 {
            
            let name = coinArray[0].lowercased()
            
            if name == "emercoin" {
                coin["name"] = name
                coin["address"] = coinArray[1]
                isSuccess = true
            }
        }
        completion(coin as AnyObject?,isSuccess)
    }
    
    class func generateQRCode(at text:String,size:CGSize, completion:@escaping (_ image: UIImage?) -> Void) {
        
        var qrCode = QRCode(text)!
        qrCode.size = size
        qrCode.errorCorrection = .High
        completion(qrCode.image!)
    }
}
