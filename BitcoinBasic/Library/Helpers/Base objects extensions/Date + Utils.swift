
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
}


