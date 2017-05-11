//
//  BCNoteViewModel.swift
//  EmercoinBasic
//

import UIKit

class RecordViewModel {

    var name = ""
    var address = ""
    var value = ""
    var expiresInDay = ""
    var expiresType = "Days"
    
    init(record:Record) {
        
        self.name = record.name
        self.address = record.address
        self.value = record.value
        self.expiresInDay = String(format:"%i",record.expiresInDays)
    }
}
