//
//  CreateNVSViewController.swift
//  EmercoinBasic
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class CreateNVSViewController: BaseViewController {
    
    @IBOutlet internal weak var prefixButton:UIButton!
    @IBOutlet internal weak var prefixDropLabel:UILabel!
    @IBOutlet internal weak var dateLabel:UILabel!
    @IBOutlet internal weak var expiresLabel:UILabel!
    @IBOutlet internal weak var prefixLabel:UILabel!
    @IBOutlet internal weak var prefixView:UIView!
    @IBOutlet internal weak var lineView:UIView!
    
    @IBOutlet internal weak var nameTextField:BaseTextField!
    @IBOutlet internal weak var valueTextField:BaseTextView!
    @IBOutlet internal weak var addressTextField:BaseTextField!
    @IBOutlet internal weak var timeTextField:ExpireDaysTextField!
    
    @IBOutlet internal weak var heightConstraint:NSLayoutConstraint!
    @IBOutlet internal weak var prefixConstraint:NSLayoutConstraint!
    
    @IBOutlet internal weak var createButton:BaseButton!
    
    var prefixDropDown:DropDown?
    
    
    var created:((Void) -> (Void))?
    var edited:((_ data:[String:Any]) -> (Void))?
    var cancel:((Void) -> (Void))?
    
    let disposeBag = DisposeBag()
    var viewModel = CreateNVSViewModel()
    
    var isEditingMode = false
    var record:Record?
    
    private var operationActivityView:UIView?
    private var nameData:AnyObject?
    private var walletProtectionHelper:WalletProtectionHelper?
    
    var data:Any? {
        didSet{
            if let dict = data as? [String:Any] {
                
                if let name = dict["name"] as? String {
                    self.name = name
                }
                
                if let prefix = dict["prefix"] as? String {
                    self.prefix = prefix
                }
            }
        }
    }
    
    var name = ""
    var prefix = ""
    
    override class func storyboardName() -> String {
        return "Names"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isEditingMode = isEditingMode
        setupController()
        setupActivityIndicator()
        setupPrefixDropDown()
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
    
    private func setupController() {
        
        valueTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
        
        timeTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
        
        nameTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
        
        addressTextField.textChanged = {[weak self](text) in
            self?.checkValidation()
        }
        
        viewModel.success.subscribe(onNext:{[weak self] success in
            if success {
                self?.showSuccessAddNameView()
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
        
        timeTextField.didFirstResponder = {[weak self](state) in
            
            if self?.isEditingMode == false {return}
            
            if state {
                if self?.timeTextField.text == "0" {
                    self?.timeTextField.text = ""
                    self?.checkValidation()
                }
            } else {
                if self?.timeTextField.text == "" {
                    self?.timeTextField.text = "0"
                    self?.checkValidation()
                }
            }
        }
    }
    
    private func checkValidation() {
        
        let value = valueTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let days = timeTextField.text ?? ""
        let address = addressTextField.text ?? ""
        
        let validAddress = isEditingMode ? address.validAddress() : true
        
        createButton.isEnabled = !value.isEmpty && !name.isEmpty && !days.isEmpty && validAddress
    }

    override func setupUI() {
        super.setupUI()
        
        hideStatusBar()
        
        if isEditingMode {
            let value = heightConstraint.constant
            heightConstraint.constant = value - 41.0
            prefixConstraint.constant = 0
            createButton.setTitle("Save", for: .normal)
            prefixView.isHidden = isEditingMode
            lineView.isHidden = isEditingMode
            expiresLabel.text = "Extend days:"
            nameTextField.disableEdit = true
            timeTextField.isEditMode = true
            createButton.isEnabled = true
            
            if let record = record {
                nameTextField.text = record.name
                valueTextField.text = record.value
                addressTextField.text = record.address
                timeTextField.text = "0"
            }
        } else {
            if name.length > 0 {
                nameTextField.text = name
            }
            
            if prefix.length > 0 {
                prefixLabel.text = prefix+":"
            }
            
            timeTextField.text = "300"
        }
        
        if isIphone5() {
            
            let font = UIFont(name: "Roboto-Regular", size: 14)
            
            nameTextField.font = font
            valueTextField.font = font
            addressTextField.font = font
        }
    }
    
    
    @IBAction func prefixButtonPressed() {
        
        prefixDropDown?.show()
    }
    
    @IBAction func createButtonPressed() {
        
        let prefix = prefixLabel.text!
        let name = nameTextField.text!
        let value = valueTextField.text!
        let address = addressTextField.text!
        var days = timeTextField.text!
        
        days = days.length > 0 ? days : "0"
        let daysCount = Int(days) ?? 0
        let expiresIn = daysCount * blocksInDay
        
        let fullName = (prefix.length > 0) ? (prefix+"\(name)") : name
        
        let record = Record(value:["name": fullName, "value":value, "address": address,
                                   "expiresIn":expiresIn, "isExpired":false])
        
        var nameData:[AnyObject] = []
        
        if isEditingMode {
            
            if let oldRecord = self.record {
                
                if oldRecord.value != record.value || oldRecord.address != record.address || daysCount > 0 {
                    record.expiresIn += oldRecord.expiresIn
                    
                    var data = [String:Any]()
                    data["address"] = record.address
                    data["value"] = record.value
                    data["name"] = record.name
                    data["expiresIn"] = record.expiresIn
                    data["expiresInDays"] = record.expiresInDays
                    
                    nameData.append(oldRecord.name as AnyObject)
                    nameData.append(record.value as AnyObject )
                    nameData.append(daysCount as AnyObject)
                    
                    if !address.isEmpty {
                        nameData.append(address as AnyObject)
                    }
                    
                    self.data = data
                    
                    viewModel.checkWalletAndSend(at: nameData as AnyObject)
                } else {
                    back()
                }
            }
        } else {
            
            if !fullName.isEmpty && !value.isEmpty && daysCount != 0 {
                nameData.append(fullName as AnyObject)
                nameData.append(value as AnyObject)
                nameData.append(daysCount as AnyObject)
                
                if !address.isEmpty {
                    nameData.append(address as AnyObject)
                }
                
                viewModel.checkWalletAndSend(at: nameData as AnyObject)
            }
        }
        self.nameData = nameData as AnyObject
    }
    
    @IBAction func cancelButtonPressed() {
        
        if cancel != nil {
            cancel!()
        }
        back()
    }
    
    @IBAction func addressButtonPressed() {
        
        if isEditingMode {
            showRecepientAddressController()
        } else {
            showAddressesController()
        }
    }
    
    private func showAddressesController() {
    
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .myAddresses
        controller.selectedAddress = {address in
            self.addressTextField.text = address
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showRecepientAddressController() {
        
        let controller = NamesViewController.controller() as! NamesViewController
        controller.subController = .recipientAddress
        controller.selectedAddress = {address in
            self.addressTextField.text = address
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showOperationActivityView() {
        
        let view = loadViewFromXib(name: "Send", index: 2,
                                   frame: self.parent!.view.frame)
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
    
    private func showSuccessAddNameView() {
        
        let successView:SuccessAddNameView! = loadViewFromXib(name: "MyRecords", index: 4,
                                                           frame: self.parent!.view.frame) as! SuccessAddNameView
        successView.success = ({[weak self] in
            
            if self?.isEditingMode == true {
                if self?.edited != nil {
                    self?.edited!(self?.data as! [String : Any])
                }
            } else {
                if self?.created != nil {
                    self?.created!()
                }
            }
            
            self?.walletProtectionHelper = nil
    
            self?.back()
        })
        
        self.parent?.view.addSubview(successView)
    }
    
    private func showErrorAlert(at error:NSError) {
        
        let alert = AlertsHelper.errorAlert(at: error)
        present(alert, animated: true, completion: nil)
    }

    private func showProtection() {
        
        if let parent = self.parent as? NamesViewController  {
            let protectionHelper = WalletProtectionHelper()
            protectionHelper.fromController = parent
            protectionHelper.cancel = {[weak self] in
                self?.nameData = nil
            }
            protectionHelper.unlock = {[weak self] in
                if let data = self?.nameData {
                    self?.viewModel.sendData(at: data)
                }
            }
            self.walletProtectionHelper = protectionHelper
            protectionHelper.startProtection()
        }
    }
}
