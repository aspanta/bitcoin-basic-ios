//
//  SendViewModel.swift
//  EmercoinBasic
//

import UIKit

class SendViewModel: CoinOperationsViewModel {
    
    func checkWalletAndSend(at sendData:AnyObject, fee:AnyObject) {
        wallet?.loadInfo(completion: {[weak self] in
            if self?.wallet?.isLocked == true {
                self?.walletLock.onNext(true)
                return
            } else {
                self?.sendCoinsWithFee(at: sendData, fee:fee)
            }
        })
    }
    
    func sendCoins(at sendData:AnyObject) {
        
        if isLoading {return}
        
        activityIndicator.onNext(true)
        isLoading = true
        
        APIManager.sharedInstance.sendCoins(at: sendData) {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            self?.isLoading = false
            if error != nil {
                self?.error.onNext(error!)
            } else {
                if let success = data as? Bool {
                    self?.success.onNext(success)
                }
            }
        }
    }
    
    func sendCoinsWithFee(at sendData:AnyObject, fee:AnyObject) {
        
        if isLoading {return}
        
        isLoading = true
        APIManager.sharedInstance.sendFee(at: fee) {[weak self] (data, error) in
            self?.isLoading = false
            if error != nil {
                self?.error.onNext(error!)
                self?.isLoading = false
            } else {
                if let state = data as? Bool {
                    if state {
                        self?.sendCoins(at: sendData)
                    }
                }
            }
        }
    }
}
