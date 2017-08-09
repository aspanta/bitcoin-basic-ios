//
//  QRCodeHelper.swift
//  EmercoinBasic
//

import UIKit
import QRCode

class QRCodeHelper {
    
    static let currency = "bitcoin"
    
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
        
        let currencyArray = array[0].components(separatedBy: ":")
        let count = currencyArray.count
        
        if count == 2 {
            
            let name = currencyArray[0].lowercased()
            let address = currencyArray[1]
            
            if name == currency {
                coin["name"] = name
                coin["address"] = address
                isSuccess = true
            }
        } else if count == 1 {
            let address = currencyArray[0]
            
            isSuccess = address.validAddress()
            
            if isSuccess {
                coin["name"] = currency
                coin["address"] = address
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
