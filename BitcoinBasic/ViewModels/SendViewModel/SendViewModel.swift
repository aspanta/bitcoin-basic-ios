//
//  SendViewModel.swift
//  EmercoinBasic
//

import UIKit

class SendViewModel: CoinOperationsViewModel {
    
    func checkWalletAndSend(at sendData:AnyObject) {
        wallet?.loadInfo(completion: {[weak self] in
            if self?.wallet?.isLocked == true {
                self?.walletLock.onNext(true)
                return
            } else {
                self?.sendCoins(at: sendData)
            }
        })
    }
    
    func sendCoins(at sendData:AnyObject) {
        
        if isLoading {return}
        
        activityIndicator.onNext(true)
        isLoading = true
        
        APIManager.sharedInstance.sendCoins(at: sendData) {[weak self] (data, error) in
            self?.activityIndicator.onNext(false)
            
            if error != nil {
                self?.error.onNext(error!)
                self?.isLoading = false
            } else {
                if let success = data as? Bool {
                    self?.success.onNext(success)
                }
            }
        }
    }
}
