//
//  CoinOperationsViewModel.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class CoinOperationsViewModel {
    
    
    let disposeBag = DisposeBag()

    var coinCourseTitle = PublishSubject<NSAttributedString>()
    var coinAmount = PublishSubject<String>()
    var coinSign = PublishSubject<String>()
    
    var success = PublishSubject<Bool>()
    var walletLock = PublishSubject<Bool>()
    var walletSuccess = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()
    var locked = PublishSubject<Bool>()
    var wallet:Wallet?
    
    internal var isLoading = false
    
    func updateUI() {
    
        if let wallet = wallet {
            
            let coin = wallet.emercoin
            
            let courseTitle = coin.exchangeAttributedString(color: .white)
            let sign = coin.sign
            let stringAmount = String(format:"%@ %@",coin.stringAmount(),sign)
            
            coinCourseTitle.onNext(courseTitle)
            coinAmount.onNext(stringAmount)
            coinSign.onNext(sign)
            locked.onNext(wallet.isLocked)
        }
    }
    
    init() {
        
        wallet = AppManager.sharedInstance.wallet
        
        if wallet != nil {
            
            wallet?.success.subscribe(onNext: {[weak self] (state) in
                self?.updateUI()
                self?.walletSuccess.onNext(state)
            })
            .addDisposableTo(disposeBag)
            
            wallet?.error.subscribe(onNext: {[weak self] (error) in
                self?.error.onNext(error)
            })
            .addDisposableTo(disposeBag)
            
            wallet?.activityIndicator.subscribe(onNext: {[weak self] (state) in
                self?.activityIndicator.onNext(state)
            })
            .addDisposableTo(disposeBag)
        }
    }
    
    func updateWallet() {
        wallet?.loadInfo(loadAll: true, completion: nil)
    }
}
