//
//  Coin.swift
//  EmercoinBasic
//
import UIKit

class Coin {
    
    var name:String?
    var amount:Double = -1
    var image:String?
    var sign = ""
    var color:String?
    var priceUSD:Double = 0

    func stringAmount() -> String {
        return amount == -1 ? "?" : String.dropZeroLast(at: String.coinFormat(at:amount))
    }
    
    func coinInUSD() -> Double {
        return amount * priceUSD
    }
    
    func exchangeAttributedString(color:UIColor? = nil) -> NSAttributedString {
        
        var fontSize:CGFloat = 15.0
        
        if isIphone5() {
            fontSize = priceUSD > 99 ? 12.0 : 15.0
        }
        
        let amountAttributes = [NSAttributedStringKey.foregroundColor: color ?? .gray, NSAttributedStringKey.font:UIFont(name: "Roboto-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)]
        
        let otherAttributes = [NSAttributedStringKey.foregroundColor: color ?? .lightGray, NSAttributedStringKey.font:UIFont(name: "Roboto-Light", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)]
        
        let countInUsd = String(format:"%0.2f",coinInUSD())
        
        let part1 = NSMutableAttributedString(string: "~"+countInUsd, attributes: amountAttributes)
        let part2 = NSMutableAttributedString(string: " USD", attributes: otherAttributes)
        let part3 = NSMutableAttributedString(string: "      ", attributes: otherAttributes)
        let part4 = NSMutableAttributedString(string: "(", attributes: otherAttributes)
        let part5 = NSMutableAttributedString(string: "1 ", attributes: amountAttributes)
        let part6 = NSMutableAttributedString(string: sign, attributes: otherAttributes)
        let part7 = NSMutableAttributedString(string: String(format:"%0.2f",priceUSD), attributes: amountAttributes)
        let part8 = NSMutableAttributedString(string: ")", attributes: otherAttributes)
        let part9 = NSMutableAttributedString(string: " = ", attributes: otherAttributes)
        
        let parts = [part1,part2,part3,part4,part5,part6,part9,part7,part2,part8]
        
        let combination = NSMutableAttributedString()
        
        for part in parts {
            combination.append(part)
        }
        return combination
    }
}
