//
//  WalletProtectionHelper.swift
//  EmercoinBasic
//

import UIKit

enum ProtectionViewType:Int {
    case unlock = 0
    case lock = 1
    case protection = 2
    case warning = 3
    case activity = 4
    case encryptActivity = 6
    case successEncrypt = 5
}

class WalletProtectionHelper {

    var cancel:((Void) -> (Void))?
    var unlock:((Void) -> (Void))?
    var fromController:UIViewController?
    var wallet = AppManager.sharedInstance.wallet
    
    func startProtection() {
        
        if wallet.isProtected {
            if wallet.isLocked {
                showUnlockView()
            } else {
                showLockView()
            }
        } else {
           // showProtectionView()
        }
    }
    
    private func showUnlockView() {
        
        let view = getProtectionView(at: .unlock) as! WalletProtectionUnlockView
        view.unlock = {(password) in
           let activity = self.showActivityView(at: .unlock)
            self.wallet.unlock(at: password, completion: {[weak self](isLock) in
                userInteraction(at: true)
                activity.removeFromSuperview()
                if self?.unlock != nil {
                    if isLock == false {
                        self?.unlock!()
                    }
                }
            })
        }
        view.cancel = {
            if self.cancel != nil {
                self.cancel!()
            }
        }
        showView(at: view)
    }
    
    private func showLockView() {
        
        let view = getProtectionView(at: .lock) as! WalletProtectionLockView
        view.lock = {
            let activity = self.showActivityView(at: .lock)
            self.wallet.lock(completion: {[weak self] (lock) in
                userInteraction(at: true)
                activity.removeFromSuperview()
            })
        }
        showView(at: view)
    }
    
    private func showProtectionView() {
        
        let view = getProtectionView(at: .protection) as! WalletProtectionView
        view.encrypt = {(password) in
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { 
                self.showWarningView(at: password)
            })

        }
        showView(at: view)
    }
    
    private func showActivityView(at type:ProtectionViewType) -> UIView {
        
        userInteraction(at: false)
        
        let view = getProtectionView(at: .activity) as! WalletProtectionActivityView
        view.type = type
        showView(at: view)
        return view
    }
    
    private func showEncryptActivityView() {
        
        let view = getProtectionView(at: .encryptActivity) as! WalletProtectionEncryptActivityView
        userInteraction(at: false)
        view.checkEncrypt = {
            self.wallet.loadInfo{
                if self.wallet.isProtected == true {
                    userInteraction(at: true)
                    view.removeFromSuperview()
                    self.showSuccessEncryptView()
                } else {
                    view.startTimer(at:30)
                }
            }
        }
        showView(at: view)
    }
    
    private func showSuccessEncryptView() {
        
        let view = getProtectionView(at: .successEncrypt)
        showView(at: view)
    }
    
    private func showWarningView(at text:String) {
        
        let view = getProtectionView(at: .warning) as! WalletProtectionWarningView
        view.encrypt = {
            self.wallet.protect(at: text)
            self.showEncryptActivityView()
        }
        showView(at: view)
    }
    
    private func getProtectionView(at type:ProtectionViewType) -> UIView {
        
        let view = loadViewFromXib(name: "WalletProtection", index: type.rawValue)
        return view
    }
    
    private func showView(at view:UIView) {
        
        if let controller = self.fromController {
            view.frame = controller.view.frame
            controller.view.addSubview(view)
        }
    }
}
