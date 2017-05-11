//
//  BlockchainLoadingViewModel.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class BlockchainLoadingViewModel {

    let disposeBag = DisposeBag()
    
    var success = PublishSubject<Bool>()
    var error = PublishSubject<NSError>()
    var blocks = PublishSubject<Int>()
    
    func loadBlockChainInfo() {
        
        APIManager.sharedInstance.loadBlockchainInfo{[weak self] (data, error) in
            if let error = error {
                self?.error.onNext(error)
            } else {
                if let blockchain = data as? Blockchain {
                    if blockchain.isLoaded {
                        self?.success.onNext(true)
                    }
                    self?.blocks.onNext(blockchain.blocks)
                }
            }
        }
    }
    
}
