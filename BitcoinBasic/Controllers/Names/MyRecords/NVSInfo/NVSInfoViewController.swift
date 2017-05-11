//
//  NVSInfoViewController.swift
//  EmercoinBasic
//

import UIKit

let nvsInfo = "Emercoin provides a service of storing name->value pairs in its blockchain without any restrictions in the data format. Each name is unique within the whole blockchain. Each name->value pair has its owner. Each owner is specified by the Emercoin payment address stored together with the pair. Only the owner of the payment address is able to modify or delete the pair, or transfer ownership to another address."

let whyInfo = "Looks like this name is not yet registered. You can become ownership for this record."

enum InfoType {
    case nvs
    case why
}

class NVSInfoViewController: BaseTextViewController {
    
    @IBOutlet internal weak var infoLabel:UILabel!
    
    var infoType:InfoType = .nvs
    
    override class func storyboardName() -> String {
        return "Names"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        super.setupUI()
        
        //statusBarView?.backgroundColor = UIColor(hexString: Constants.Colors.Status.Blockchain)
        
        var text = ""
        
        switch infoType {
            case .nvs:text = nvsInfo
            case .why:text = whyInfo
        }
        
        let font = UIFont(name: "Helvetica", size: 14)!
        let attributes = [NSForegroundColorAttributeName:UIColor(hexString: "#333333"), NSFontAttributeName:font]
        let string = NSMutableAttributedString(string: text, attributes: attributes)
        
        infoLabel.attributedText = string
    }
}
