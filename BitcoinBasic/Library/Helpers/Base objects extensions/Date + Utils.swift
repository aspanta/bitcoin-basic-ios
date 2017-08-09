
//
//  Date + Utils.swift
//  Emercoin
//


import UIKit

extension Date {
    
    func stringDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from:self)
        return dateString
    }
    
    func transactionStringDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from:self)
        return dateString
    }
    
    func transactionStringDateFull() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from:self)
        return dateString
    }
    
    static func fromString(string:String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date ?? Date()
    }
}


