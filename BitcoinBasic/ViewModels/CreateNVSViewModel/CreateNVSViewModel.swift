//
//  CreateNVSViewModel.swift
//  EmercoinBasic
//

import UIKit

class CreateNVSViewModel:CoinOperationsViewModel {
    
    var isEditingMode = false
    
    func checkWalletAndSend(at sendData:AnyObject) {
        wallet?.loadInfo(completion: {[weak self] in
            if self?.wallet?.isLocked == true {
                self?.walletLock.onNext(true)
                return
            } else {
                self?.sendData(at: sendData)
            }
        })
    }
    
    func sendData(at sendData:AnyObject) {
        
        if isLoading {return}
        
        activityIndicator.onNext(true)
        isLoading = true
        
        if isEditingMode {
            APIManager.sharedInstance.updateName(at: sendData) {[weak self] (data, error) in
               self?.processingrResponse(data: data, error: error)
            }
        } else {
            APIManager.sharedInstance.addName(at: sendData) {[weak self] (data, error) in
                self?.processingrResponse(data: data, error: error)
            }
        }
    }
    
    private func processingrResponse(data:AnyObject?, error:NSError?) {
        
        activityIndicator.onNext(false)
        
        if error != nil {
            self.error.onNext(error!)
            isLoading = false
        } else {
            if let success = data as? Bool {
                self.success.onNext(success)
            }
        }
    }
}
