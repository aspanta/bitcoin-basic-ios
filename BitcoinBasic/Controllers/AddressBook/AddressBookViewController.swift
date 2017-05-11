//
//  AddressBookViewController.swift
//  EmercoinBasic
//

import UIKit
import RxCocoa
import RxSwift

class AddressBookViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet internal weak var menuButton:UIButton!
    @IBOutlet internal weak var backButton:UIButton!
    @IBOutlet internal weak var addButton:UIButton!
    @IBOutlet internal weak var noAddressesView:UIView!
    @IBOutlet internal weak var lockButton:LockButton!
    
    @IBOutlet internal weak var tableView:UITableView!
    
    var selectedAddress:((_ text:String) -> (Void))?
    
    var addressBook = AddressBook()
    private var wallet = AppManager.sharedInstance.wallet
    
    let disposeBag = DisposeBag()
    
    var isFromMenu = false
    
    override class func storyboardName() -> String {
        return "AddressBook"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.baseSetup()
        setupAddresses()
        updateUI()
    }
    
    override func setupUI() {
        super.setupUI()
        
        wallet.success.subscribe(onNext: {[weak self] (state) in
            self?.updateUI()
        })
         .addDisposableTo(disposeBag)
    }
    
    internal func updateUI() {
        
        noAddressesView.isHidden = addressBook.contacts.count != 0
        lockButton.isLocked = wallet.isLocked
    }
    
    private func setupAddresses() {
        
        addressBook.success.subscribe(onNext:{ [weak self] success in
            if success {
                self?.tableView.reload()
                self?.updateUI()
            }
        }).addDisposableTo(disposeBag)
    }
    
    @IBAction func addButtonPressed(sender:UIButton) {
        
        showAddContactView()
    }
    
    private func showAddContactView() {
        
        let addContactView = loadViewFromXib(name: "AddressBook", index: 1,
                                                                   frame: self.parent!.view.frame) as! AddContactView
        addContactView.add = ({(name, address) in
            self.addressBook.add(contact: Contact(value:["name":name, "address": address,"isMyContact":false]))
            self.tableView.reload()
        })
        self.parent?.view.addSubview(addContactView)
    }
    
    override func back() {
        if isFromMenu {
            backToDashBoard()
        } else {
            super.back()
        }
    }
}
