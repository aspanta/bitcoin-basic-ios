//
//  AddressBook.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift
import RxRealm

class AddressBook {
    
    var contacts:Results<Contact> {
        get {
            let realm = try! Realm()
            return realm.objects(Contact.self).filter("isMyContact == false")
        }
    }
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    var isEmpty = PublishSubject<Bool>()
    
    init() {
        
        Observable.changeset(from: contacts)
            .subscribe(onNext: {results, changes in
                self.isEmpty.onNext(results.count == 0)
                
                if changes?.inserted.count != 0 || changes?.updated.count != 0 {
                    self.success.onNext(true)
                }
            })
        .addDisposableTo(disposeBag)
    }
    
    func add(contact:Contact) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(contact)
        }
    }
    
    func add(contacts:[Contact]) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(contacts)
        }
    }
    
    func remove(contact:Contact) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func remove(contacts:[Contact]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(contacts)
        }
    }
    
    func update(at name:String, index:Int) {
        let realm = try! Realm()
        try! realm.write {
            contacts[index].name = name
        }
    }
    
    func update(at name:String, address:String, index:Int) {
        let realm = try! Realm()
        try! realm.write {
            contacts[index].name = name
            contacts[index].address = address
        }
    }
    
    func load(loadAll:Bool? = false) {
        
    }
    
    func addNewMyAddress(at name:String) {
    
    }
}
