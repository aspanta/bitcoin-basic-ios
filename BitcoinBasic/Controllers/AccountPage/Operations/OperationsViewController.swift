//
//  OperationsViewController.swift
//  EmercoinBasic
//

import UIKit

class OperationsViewController: UIViewController, IndicatorInfoProvider {
    
    override class func storyboardName() -> String {
        return "AccountPage"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Operations")
    }
    
    @IBAction func sendButtonPressed(sender:UIButton) {
        showSendController()
    }
    
    @IBAction func myAddressButtonPressed(sender:UIButton) {
        showMyAddressController()
    }
    
    @IBAction func addMoneyButtonPressed(sender:UIButton) {
        print("addMoneyButtonPressed")
    }
    
    @IBAction func receiveButtonPressed(sender:UIButton) {
        showReceiveController()
    }

    private func showSendController() {
        
        let controller = getController(at: .recipientAddress)
        push(at: controller)
    }
    
    private func showReceiveController() {
        
        let controller = getController(at: .get)
        push(at: controller)
    }
    
    private func showMyAddressController() {
        
        let controller = getController(at: .myAddress)
        push(at: controller)
    }
    
    private func push(at controller:UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func getController(at operationType:CoinsOperation) -> UIViewController {
        
        let controller = CoinOperationsViewController.controller() as! CoinOperationsViewController
        controller.coinsOperation = operationType
        return controller
    }
}
