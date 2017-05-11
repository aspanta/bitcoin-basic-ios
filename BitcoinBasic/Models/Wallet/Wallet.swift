//
//  Wallet.swift
//  EmercoinBasic
//

import UIKit
import ObjectMapper
import RxCocoa
import RxSwift

class Wallet:BaseModel {
    
    var success = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    
    var emercoin:Coin = {
        let emCoin = Coin()
        emCoin.name = "EMERCOIN"
        emCoin.amount = 0.0
        emCoin.image = "emer_icon_1"
        emCoin.sign = "EMC"
        emCoin.color = Constants.Colors.Coins.Emercoin
        return emCoin
    }()
    
    var isLocked = false
    var isProtected = false
    var isMintonly = false
    
    private var unlockedUntil = 1 {
        didSet {
            isLocked = unlockedUntil == 0
        }
    }
    
    init(amount:Double) {
        emercoin.amount = amount
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    var balance:Double = 0.0 {
        didSet{
            emercoin.amount = balance
            success.onNext(true)
        }
    }
    
    override func mapping(map: Map) {
        
        isMintonly <- map["mintonly"]
        unlockedUntil <- map["unlocked_until"]
        isProtected <- map["encrypted"]
        balance <- map["balance"]
    }
    
    func loadInfo(loadAll:Bool? = false, completion:((Void) -> Void)? = nil) {
        
        APIManager.sharedInstance.loadInfo{[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            if error != nil {
                self?.error.onNext(error!)
            } else {
                
                if loadAll == true {
                    APIManager.sharedInstance.loadAll()
                }
                
                if let wallet = data as? Wallet {
                    self?.isLocked = wallet.isLocked
                    self?.isProtected = wallet.isProtected
                    self?.isMintonly = wallet.isMintonly
                    self?.balance = wallet.balance
                }
            }
            if completion != nil {
                completion!()
            }
        }
        loadCourse()
    }
    
    func loadCourse() {
        APIManager.sharedInstance.loadEmercoinCourse {[weak self] (data, error) in
            if let priceUSD = Double(data as! String) {
                self?.emercoin.priceUSD = priceUSD
                self?.success.onNext(true)
            }
        }
    }
}
