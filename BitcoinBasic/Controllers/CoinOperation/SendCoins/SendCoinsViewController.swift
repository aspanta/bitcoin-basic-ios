//
//  SendCoinsViewController.swift
//  EmercoinBasic
//

import UIKit
import RxSwift
import RxCocoa

class SendCoinsViewController: BaseViewController {
    
    private let fee = [0.00136222,0.00148372,0.00162258,0.00179907,0.00199912]
    private var feeValue = 0.00179907
    @IBOutlet internal weak var feeLabel:UILabel!
    @IBOutlet internal weak var feeSlider:BaseSlider!
    
    @IBOutlet internal weak  var addressTextField:BaseTextField!
    @IBOutlet internal weak  var signLabel:UILabel!
    @IBOutlet internal weak  var sendButton:BaseButton!
    @IBOutlet internal weak  var amountTextField:BaseTextField!
    
    private var operationActivityView:UIView?
    private var amount:Double = 0
    private var sendData:AnyObject?
    private var walletProtectionHelper:WalletProtectionHelper?
    
    let disposeBag = DisposeBag()
    var viewModel = SendViewModel()
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSend()
        setupActivityIndicator()
    }
    
    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
        viewModel.coinSign.bind(to: signLabel.rx.text)
        .addDisposableTo(disposeBag)
        
        if let wallet = viewModel.wallet {
            
            let index = wallet.feeIndex
            
            feeSlider.value = Float(index)
            feeValue = fee[index]
            
            updateFee()
        }
        
        if object != nil {
            guard let dict = object as? [String:Any] else {
                return
            }
            
            guard let address = dict["address"] as? String else {
                return
            }
            addressTextField.text = address
            
            guard let amount = dict["amount"] as? String else {
                return
            }
            amountTextField.text = amount
            sendButton.isEnabled = true
        }
    }
    
    private func updateFee() {
        
        feeLabel.text = String(format:"%0.8f BTC/Kb",feeValue)
    }
    
    private func setupSend() {
        
        viewModel.success.subscribe(onNext:{[weak self] success in
            if success {
                let wallet = AppManager.sharedInstance.wallet
                wallet.balance -= self?.amount ?? 0
                wallet.loadInfo(completion: nil)
                self?.showSuccesSendView()
            }
        })
            .addDisposableTo(disposeBag)
        
        viewModel.error.subscribe(onNext:{ [weak self] error in
            self?.showErrorAlert(at: error)
        })
            .addDisposableTo(disposeBag)
        
        viewModel.walletLock.subscribe(onNext:{ [weak self] state in
            self?.showProtection()
        })
            .addDisposableTo(disposeBag)
        
        addressTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
        
        amountTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
    }
    
    private func checkValidation() {
        
        let address = addressTextField.text ?? ""
        var amount = amountTextField.text ?? ""
        
        amount = amount.replaceСommas()
        
        let isValidAddress = address.validAddress()
        let isValidAmount = amount.validAmount()
        
        sendButton.isEnabled = isValidAddress  && isValidAmount
    }
    
    private func setupActivityIndicator() {
        
        viewModel.activityIndicator.subscribe(onNext:{ [weak self] state in
            if state {
                self?.showOperationActivityView()
            } else {
                self?.hideOperationActivityView()
            }
        })
            .addDisposableTo(disposeBag)
    }
    
    private func addRequestSendView() {
    
        var amount = amountTextField.text ?? ""
        amount = amount.replacingOccurrences(of: ",", with: ".")
        amount = String.dropZeroLast(at: amount)
        amount = String.dropZeroFirst(at: amount)
        self.amount = Double(amount) ?? 0
        let address = addressTextField.text
        
        if (amount.length) > 0 && (address?.length)! > 0  {
        
            let requestSendView:RequestSendView! = loadViewFromXib(name: "Send", index: 0,
                                                                   frame: self.parent!.view.frame) as! RequestSendView
            
            requestSendView.amount = amount
            requestSendView.sendCoins = ({[weak self] in
                let data = [address ?? "", self?.amount as Any] as AnyObject
                self?.sendData = data
                self?.viewModel.checkWalletAndSend(at: data)
            })
             self.parent?.view.addSubview(requestSendView)
        }
    }
    
    private func showSuccesSendView() {
        
        let successView:SuccessSendView! = loadViewFromXib(name: "Send", index: 1,
                                                           frame: self.parent!.view.frame) as! SuccessSendView
        successView.success = ({
            
            let parent  = self.parent as! CoinOperationsViewController
            self.walletProtectionHelper = nil
            parent.back()
        })
        
        self.parent?.view.addSubview(successView)
    }
    
    private func showOperationActivityView() {
        
        let view = getView(at: 2)
        self.operationActivityView = view
        userInteraction(at: false)
        self.parent?.view.addSubview(view)
    }
    
    private func hideOperationActivityView() {
        
        if let view = operationActivityView {
            userInteraction(at: true)
            view.removeFromSuperview()
        }
    }
    
    private func getView(at index:Int) -> UIView {
        let view = loadViewFromXib(name: "Send", index: index,
                                   frame: self.parent!.view.frame)
        return view
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(sender:UIButton) {
        
        addRequestSendView()
    }
    
    @IBAction internal func changeValueFeeSlider(sender:UISlider) {
        let index = Int(sender.value)
        
        if index < fee.count {
            feeValue = fee[index]
            
            if let wallet = viewModel.wallet {
                wallet.feeIndex = index
            }
            updateFee()
        }
    }
    
    private func showProtection() {
        
        if let parent = self.parent as? CoinOperationsViewController  {
            let protectionHelper = WalletProtectionHelper()
            protectionHelper.fromController = parent
            protectionHelper.cancel = {[weak self] in
                self?.sendData = nil
            }
            protectionHelper.unlock = {[weak self] in
                if let data = self?.sendData {
                    self?.viewModel.sendCoins(at: data)
                }
            }
            self.walletProtectionHelper = protectionHelper
            protectionHelper.startProtection()
        }
    }
}
