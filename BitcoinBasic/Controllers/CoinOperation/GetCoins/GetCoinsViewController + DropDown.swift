//
//  GetCoinsViewController + DropDown.swift
//  EmercoinBasic
//

import UIKit

extension GetCoinsViewController {
    
    internal func setupDropDown() {
        
        let myAddressBook = AppManager.sharedInstance.myAddressBook
        myAddressBook.load()
        
        myAddressBook.success.subscribe(onNext:{ [weak self] success in
            if success {
                self?.setupDataSource(at: myAddressBook)
            }
        })
        .addDisposableTo(disposeBag)
        
        dropDown = DropDown()
        dropDown?.anchorView = dropDownButton
        
        setupDataSource(at: myAddressBook)
        
        dropDown?.selectionAction = { [weak self] (index, item) in
            self?.addressLabel.text = item
            self?.address = myAddressBook.contacts[index].address
            self?.generateQRCode(at:self?.address ?? "")
        }
        
        dropDown?.bottomOffset = CGPoint(x: 0, y: dropDownButton.bounds.height)

        setupDropDownUI()
        
    }
    
    private func setupDataSource(at addressbook:MyAddressBook) {
        
        self.dropDown?.dataSource = addressbook.addressesArray()
        
        let firstAddress = addressbook.addressesArray().first ?? ""
        self.address = firstAddress
        
        self.addressLabel.text = firstAddress
        self.dropDown?.reloadAllComponents()
    }
    
    internal func setupDropDownUI() {
        
        let appearance = DropDown.appearance()
        appearance.selectionBackgroundColor = coinSignLabel.textColor
        appearance.cellHeight = dropDownButton.bounds.height + 5
        appearance.textFont = UIFont(name: "Roboto-Regular", size: 18)!
    }
    
    @IBAction func dropButtonPressed() {
        
        dropDown?.show()
    }
}
