//
//  Wallet + Protection.swift
//  EmercoinBasic
//

import UIKit

extension Wallet {
    
    func protect(at password:String, completion:((_ protected:Bool) -> Void)? = nil) {
        
        APIManager.sharedInstance.protectWallet(at: [password] as AnyObject) {[weak self] (data, error) in
            if let error = error {
                if completion != nil {
                    completion!(false)
                }
                self?.error.onNext(error)
            } else {
                self?.loadInfo(completion: {[weak self] in
                    if completion != nil {
                        if let protect = self?.isProtected {
                            completion!(protect)
                        }
                    }
                })
            }
        }
    }
    
    func unlock(at password:String, completion:((_ unlock:Bool) -> Void)? = nil) {
        APIManager.sharedInstance.unlockWallet(at: [password, 3000] as AnyObject) {[weak self] (data, error) in
            self?.showErrorOrLoadInfo(at:error, completion: completion)
        }
    }
    
    func lock(completion:((_ lock:Bool) -> Void)? = nil) {
        APIManager.sharedInstance.lockWallet {[weak self] (data, error) in
            self?.showErrorOrLoadInfo(at:error, completion: completion)
        }
    }
    
    func showErrorOrLoadInfo(at error:NSError?, completion:((_ lock:Bool) -> Void)? = nil ) {
        if let error = error {
            if completion != nil {
                completion!(false)
            }
            self.error.onNext(error)
        } else {
            self.loadInfo(completion: {[weak self] in
                if completion != nil {
                    if let lock = self?.isLocked {
                        completion!(lock)
                    }
                }
            })
        }
    }
}
