//
//  ApiManager.swift
//  Emercoin Basic
//

import UIKit

enum APIType {
    case balance
    case info
    case transactions
    case sendCoins
    case myAddresses
    case myNewAddress
    case names
    case addName
    case updateName
    case deleteName
    case searchName
    case protectWallet
    case lockWallet
    case unlockWallet
    case blockchainInfo
}

class APIManager: NSObject {
    
    internal static let sharedInstance = APIManager()
    
    private var apies:[BaseAPI] = []
    
    private var authInfo:[String:String] = [:]
    
    func addApi(at api:BaseAPI) {
        apies.append(api)
    }
    
    func removeApi(at api:BaseAPI) {
        apies.remove(object: api)
    }
    
    func removeAll() {
        apies.removeAll()
    }
    
    func cancelAllRequests() {
        
        for api in apies {
            api.dataTask?.cancel()
        }
        
        removeAll()
    }
    
    func addAuthInfo(at authInfo:[String:String]) {
        
        self.authInfo = authInfo
    }
    
    func login(at authInfo:[String:String], completion:@escaping (_ data: AnyObject?,_ error:NSError?) -> Void) {
        
        self.authInfo = authInfo
        loadBlockchainInfo(completion: completion)
    }
    
    func loadInfo(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .info)
        api.startRequest(completion: completion)
    }
    
    func loadBlockchainInfo(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .blockchainInfo)
        api.startRequest(completion: completion)
    }
    
    func loadTransactions(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .transactions)
        api.startRequest(completion: completion)
    }
    
    func loadAll() {
        
        loadBalance{ (data, error) in
            if error == nil {
                self.loadMyAddresses{ (data, error) in
                    if error == nil {
                        self.loadTransactions{ (data, error) in
                            if error == nil {
                                self.loadNames{ (data, error) in
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loadBalance(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .balance)
        api.startRequest(completion: completion)
    }
    
    func sendCoins(at sendData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .sendCoins)
        
        if var params = api.object as? [String:AnyObject] {
            params["sendData"] = sendData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func addName(at nameData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .addName)
        
        if var params = api.object as? [String:AnyObject] {
            params["nameData"] = nameData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func updateName(at nameData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .updateName)
        
        if var params = api.object as? [String:AnyObject] {
            params["nameData"] = nameData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func protectWallet(at protectData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .protectWallet)
        
        if var params = api.object as? [String:AnyObject] {
            params["protectData"] = protectData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func unlockWallet(at unlockData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .unlockWallet)
        
        if var params = api.object as? [String:AnyObject] {
            params["unlockData"] = unlockData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func lockWallet(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .lockWallet)
        api.startRequest(completion: completion)
    }
    
    func deleteName(at nameData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .deleteName)
        
        if var params = api.object as? [String:AnyObject] {
            params["nameData"] = nameData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func searchName(at nameData:AnyObject, completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .searchName)
        
        if var params = api.object as? [String:AnyObject] {
            params["nameData"] = nameData as AnyObject?
            api.object = params as AnyObject?
        }
        
        api.startRequest(completion: completion)
    }
    
    func loadMyAddresses(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .myAddresses)
        api.startRequest(completion: completion)
    }
    
    func loadNames(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .names)
        api.startRequest(completion: completion)
    }
    
    func loadMyNewAddress(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = getApi(at: .myNewAddress)
        api.startRequest(completion: completion)
    }
    
    func loadEmercoinCourse(completion:@escaping (_ data: AnyObject?, _ error:NSError?) -> Void) {
        
        let api = EmercoinCourseAPI()
        api.startRequest(completion: completion)
    }
    
    private func getApi(at type:APIType) -> BaseAPI {
        
        var api:BaseAPI = BaseAPI()
        
        switch type {
            case .balance:api = BalanceAPI()
            case .info:api = InfoAPI()
            case .transactions:api = TransactionsAPI()
            case .sendCoins:api = SendCoinsAPI()
            case .myAddresses:api = MyAddressesAPI()
            case .myNewAddress:api = AddMyAddressAPI()
            case .names:api = NamesAPI()
            case .addName:api = AddNameAPI()
            case .updateName:api = UpdateNameAPI()
            case .deleteName:api = DeleteNameAPI()
            case .protectWallet:api = ProtectWalletAPI()
            case .lockWallet:api = LockWalletAPI()
            case .unlockWallet:api = UnlockWalletAPI()
            case .searchName:api = SearchNameAPI()
            case .blockchainInfo:api = BlockchainInfoAPI()
        }
        
        api.object = authInfo as AnyObject?
        
        addApi(at: api)
        api.done = {
            self.removeApi(at: api)
        }

        return api
    }
}
