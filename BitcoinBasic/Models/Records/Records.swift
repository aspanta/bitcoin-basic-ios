//
//  BCNotes.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift
import RxRealm

class Records {
    
    var records:Results<Record> {
        get {
            let realm = try! Realm()
            return realm.objects(Record.self)
        }
    }
    var searchRecords:[Record] = []
    
    var searchString = ""
    
    
    let disposeBag = DisposeBag()
    var success = PublishSubject<Bool>()
    var successDelete = PublishSubject<Bool>()
    var walletLock = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    var isEmpty = PublishSubject<Bool>()
    
    init() {
        
//        Observable.changeset(from: records)
//            .subscribe(onNext: {results, changes in
//                if let changes = changes {
//                    if changes.deleted.count == 0 {
//                        self.success.onNext(true)
//                    }
//                }
//            })
//            .addDisposableTo(disposeBag)
    }
    
    func add(record:Record) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(record)
        }
    }
    
    func add(records:[Record]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(records)
        }
    }
    
    func checkWalletAndRemove(at record:Record) {
        let wallet = AppManager.sharedInstance.wallet
        wallet.loadInfo(completion: {[weak self] in
            if wallet.isLocked == true {
                self?.walletLock.onNext(true)
                return
            } else {
                self?.remove(record:record)
            }
        })
    }
    
    func remove(record:Record) {
        activityIndicator.onNext(true)
        APIManager.sharedInstance.deleteName(at: [record.name] as AnyObject) {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            if let error = error {
               self?.error.onNext(error)
            } else {
                self?.successDelete.onNext(true)
            }
        }
    }
    
    func removeAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(records)
        }
    }

    func update(at data:[String:Any], index:Int) {
        let realm = try! Realm()
        try! realm.write {
            let record = records[index]
            record.address = (data["address"] as? String) ?? ""
            record.expiresIn = (data["expiresIn"] as? Int) ?? 0
            record.value = (data["value"] as? String) ?? ""
            record.name = (data["name"] as? String) ?? ""
            record.expiresInDays = (data["expiresInDays"] as? Int) ?? 0
        }
    }
    
    func load(loadAll:Bool? = false, completion:((Void) -> Void)? = nil) {
        
        APIManager.sharedInstance.loadNames {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            if error == nil {
                if loadAll == true {
                    APIManager.sharedInstance.loadAll()
                }
                self?.success.onNext(true)
            } else {
                self?.error.onNext(error!)
            }
            if completion != nil{
                completion!()
            }
        }
    }
    
    func searchName(completion:((Void) -> Void)? = nil) {
        
        load {[weak self] in
            APIManager.sharedInstance.searchName(at: [self?.searchString] as AnyObject, completion: {[weak self] (data, error) in
                if error == nil {
                    guard let record = data as? Record else {
                        return
                    }
                    
                    let realm = try! Realm()
                    
                    if realm.objects(Record.self).filter("name == %@",record.name).count == 0 {
                        record.isMyRecord = false
                    }
                    
                    var result = true
                    
                    if record.isDeleted || record.isExpired {
                        result = false
                    } else {
                        self?.searchRecords.append(record)
                    }
                    
                    self?.success.onNext(result)
                } else {
                    self?.success.onNext(false)
                }
                
                if completion != nil {
                    completion!()
                }
            })
        }
    }
}
