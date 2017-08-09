//
//  LoginViewModel.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel {
    
    var host:String = "" {didSet{validateCredentials()}}
    var port:String = "" {didSet{validateCredentials()}}
    var webProtocol:String = "" {didSet{validateCredentials()}}
    
    var login:String = "" {didSet{validateCredentials()}}
    var password:String = "" {didSet{validateCredentials()}}
    
    var topConstraint = PublishSubject<CGFloat>()
    var topButtonConstraint = PublishSubject<CGFloat>()
    var leftConstraint = PublishSubject<CGFloat>()
    var isValidCredentials = PublishSubject<Bool>()
    var successLogin = PublishSubject<Bool>()
    var blocks = PublishSubject<Int>()
    var error = PublishSubject<NSError>()
    var activityIndicator = PublishSubject<Bool>()

    var isLoading = false
    
    private var settings = AppManager.sharedInstance.settings
    
    func validateCredentials() {
        
        let valid = host.length > 0 && port.length > 0 && webProtocol.length > 0 && login.length > 0
            && password.length > 0
        
        isValidCredentials.onNext(valid)
    }
    
    func prepareUI() {
        
        if isIphone5() {
            let value = Constants.Constraints.Login.Top.iphone5
            topConstraint.onNext(CGFloat(value))
            leftConstraint.onNext(CGFloat(value))
            topButtonConstraint.onNext(CGFloat(value + 12))
        }
    }
    
    func performLogin() {
        
        if isLoading {return}
        
        var authInfo = [String:String]()
        
        authInfo["host"] = host
        authInfo["port"] = port
        authInfo["user"] = login
        authInfo["password"] = password
        authInfo["protocol"] = webProtocol
        
        activityIndicator.onNext(true)
        isLoading = true
        
        APIManager.sharedInstance.login(at: authInfo) {[weak self] (data, error) in
            self?.isLoading = false
            self?.activityIndicator.onNext(false)
            if error != nil {
                self?.error.onNext(error!)
            } else {
                
                if self?.settings.authInfo == nil {
                    self?.settings.authInfo = authInfo
                    self?.settings.save()
                }
                
                if let blockchain = data as? Blockchain {
                    if blockchain.isLoaded == false {
                        self?.blocks.onNext(blockchain.blocks)
                    } else {
                         self?.successLogin.onNext(true)
                    }
                }
            }
        }
    }
}
