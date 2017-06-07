//
//  String + Utils.swift
//  EmercoinBasic
//

import Foundation

extension String {
    
    var isEmpty:Bool {
        return length == 0
    }
    
    var first: String {
        return String(characters.prefix(1))
    }
    
    var second: String? {
        let ind = index(startIndex, offsetBy: 1)
        
        if self.length > 1 {
            return String(self[ind])
        } else {
            return nil
        }
    }
    
    var last: String {
        return String(characters.suffix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
    
    var length: Int {
        return characters.count
    }
    
    func insert(_ string:String,index:Int) -> String {
        return  String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count-index))
    }
    
    func removeLast() -> String {
        return String(characters.dropLast())
    }
    func removeFirst() -> String {
        return String(characters.dropFirst())
    }

    
    func stringTo(_ index:Int) -> String {
        return  String(self.characters.prefix(index))
    }
    
    static func dropZeroLast(at text:String) -> String {
        
        var string = text
        
        let ch = string.last
        
        if ch == "0" {
            string = string.removeLast()
            string = dropZeroLast(at:string)
        } else if ch == "." {
            string = string.removeLast()
        }
        
        return string
    }
    
    static func dropZeroFirst(at text:String) -> String {
        
        var string = text
        
        let ch = string.first
        
        if ch == "0" {
            string = string.removeFirst()
            string = dropZeroFirst(at:string)
        } else if ch == "." {
            string  = "0" + string
        }
        return string
    }
    
    func replaceСommas() -> String {
        return self.replacingOccurrences(of: ",", with: ".")
    }
    
    static func randomStringWithLength (_ len : Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString as String
    }
    
    static func coinFormat(at number:Double) -> String {
        let string = number.truncatingRemainder(dividingBy: 1.0) == 0 ? String(format: "%.0f", number) : String(format: "%.8f", number)
        return string
    }
    
    static func isInfoCardType(at string:String) -> Bool {
        let infoCardRegEx = "^info:[0-9a-fA-F]{16}$"
        let infoCardTest = NSPredicate(format:"SELF MATCHES %@", infoCardRegEx)
        return infoCardTest.evaluate(with: string)
    }
    
    func validAmount() -> Bool {
        let number = Double(self) ?? 0.0
        return number != 0
    }
    
    func validAddress() -> Bool {
        return validData(at: "[1,3]{1}[A-Za-z0-9]{26,33}$")
    }
    
    func containOnlyZero() -> Bool {
        return validData(at: "(?!^0+$)^.{1,}")
    }
    
    private func validData(at pattern:String) -> Bool {
        let regex = try! NSRegularExpression(pattern:pattern, options:[])
        let nsString = self as NSString
        let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        let strings = results.map{nsString.substring(with: $0.range)}
        return strings.first != nil && strings.first == self
    }
}
