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
    
    var bitcoin:Coin = {
        let coin = Coin()
        coin.name = "BITCOIN"
        coin.amount = 0.0
        coin.image = "bit_icon_1"
        coin.sign = "BTC"
        coin.color = Constants.Colors.Coins.Bitcoin
        return coin
    }()
    
    var feeIndex = 1
    
    var isLocked = false
    var isProtected = false
    var isMintonly = false
    
    private var unlockedUntil = 1 {
        didSet {
            isLocked = unlockedUntil == 0
        }
    }
    
    init(amount:Double) {
        bitcoin.amount = amount
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    var balance:Double = 0.0 {
        didSet{
            bitcoin.amount = balance
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
        APIManager.sharedInstance.loadBitcoinCourse {[weak self] (data, error) in
            if let priceUSD = Double(data as! String) {
                self?.bitcoin.priceUSD = priceUSD
                self?.success.onNext(true)
            }
        }
    }
}
