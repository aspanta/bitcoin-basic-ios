//
//  RecipientAddressViewController.swift
//  EmercoinBasic
//

import UIKit

class RecipientAddressViewController: BaseViewController {
    
    override class func storyboardName() -> String {
        return "CoinOperations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let data = object {
            showSendController(at: data as? [String : Any])
            object = nil
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        statusBarView?.isHidden = true
    }
    
    @IBAction func qrCodeButtonPressed(sender:UIButton) {
        showScanQRCodeController()
    }
    
    @IBAction func listButtonPressed(sender:UIButton) {
        print("listButtonPressed")
        showAddressBookController()
    }
    
    @IBAction func enterButtonPressed(sender:UIButton) {
        showSendController(at:nil)
    }
    
    func showSendController(at data:[String:Any]?) {
    
        let controller = CoinOperationsViewController.controller() as! CoinOperationsViewController
        controller.coinsOperation = .send
        controller.object = data as AnyObject?
        push(at: controller)
    }
    
    private func showAddressBookController() {

        let controller = AddressBookViewController.controller() as! AddressBookViewController
        controller.selectedAddress = {(address)in
            var dict:[String:Any] = [:]
            dict["address"] = address
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.showSendController(at: dict)
            }
        }

        push(at: controller)
    }
    
    private func showScanQRCodeController() {
        
        let controller = ScanQRCodeController.controller() as! ScanQRCodeController
        controller.scanned = {(data)in
            let dict = data as! [String:Any]
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.showSendController(at: dict)
            }
        }
        present(controller, animated: true, completion: nil)
        //push(at: controller)
    }
    
    private func push(at controller:UIViewController) {
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
