//
//  BlockchainLoadingViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class BlockchainLoadingViewController: BaseViewController {

    private weak var blockchainLoadingView:BlockchainLoadingView?
    private var viewModel = BlockchainLoadingViewModel()
    private let disposeBag = DisposeBag()
    
    private var isErrorShowing = false
    
    var blocks = 0
    
    override class func storyboardName() -> String {
        return "BlockchainLoading"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
        showBlockchainLoadingView(at:blocks)
    }
    
    private func setupController() {
    
        viewModel.success.subscribe(onNext: {[weak self] (state) in
            if state == true {
                self?.hideBlockchainLoadingView()
                self?.showMainController()
            }
        })
            .addDisposableTo(disposeBag)
        
        viewModel.blocks.subscribe(onNext: {[weak self] (blocks) in
            self?.showBlockchainLoadingView(at: blocks)
        })
            .addDisposableTo(disposeBag)
        
        viewModel.error.subscribe(onNext:{ [weak self] error in
            if self?.isErrorShowing == false {self?.showErrorAlert(at: error)}
            
        }).addDisposableTo(disposeBag)
    }
    
    private func showMainController() {
        
        Router.sharedInstance.showMainController()
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        alert.done = {[weak self] in
            self?.isErrorShowing = false
        }
        present(alert, animated: true, completion: nil)
        isErrorShowing = true
    }
    
    private func showBlockchainLoadingView(at blocks:Int) {
        
        if let view = blockchainLoadingView {
            view.blocks = blocks
        } else {
            let view = loadViewFromXib(name: "Blockchain", index: 0, frame: self.view.frame) as! BlockchainLoadingView
            view.blocks = blocks
            view.checkBlockchain = {[weak self] in
                self?.viewModel.loadBlockChainInfo()
            }
            view.cancel = {[weak self] in
                self?.hideBlockchainLoadingView()
                self?.blockchainLoadingView?.removeFromSuperview()
                self?.blockchainLoadingView = nil
                AppManager.sharedInstance.logOut()
            }
            self.blockchainLoadingView = view
            self.view.addSubview(view)
        }
    }
    
    private func hideBlockchainLoadingView() {
        
        if let view = blockchainLoadingView {
            view.stopTimer()
            view.removeFromSuperview()
        }
    }

}
