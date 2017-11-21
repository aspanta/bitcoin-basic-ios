//
//  AboutViewController.swift
//  EmercoinBasic
//

import UIKit

let aboutText = "«Bitcoin Basic» is a remote controller for the Bitcoin Core Wallet running on your computer or hosted server in a daemon mode. \n\n«Aspanta Limited» is an expert in the development of highly loaded web and mobile full-cycle applications, reliable Microsoft Azure cloud resources, decentralized systems based on the Emercoin blockchain."

class AboutViewController: BaseTextViewController {

    @IBOutlet internal weak var textLabel:FRHyperLabel!
    
    private var basicLink = "https://www.aspanta.com/project/btcbasic"
    private var aspantaLink = "https://www.aspanta.com"
    
    private var basic = "«Bitcoin Basic»"
    private var aspanta = "«Aspanta Limited»"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        let font = UIFont.systemFont(ofSize: 15.0)
        
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                          NSAttributedStringKey.font: font]
        
        textLabel.attributedText = NSAttributedString(string: aboutText, attributes: attributes)
        
        let handler = {[weak self]
            (hyperLabel: FRHyperLabel?, substring: String?) -> Void in
            
            var url = ""
            
            if substring == self?.basic {
                url = self?.basicLink ?? ""
            } else if substring == self?.aspanta {
                url = self?.aspantaLink ?? ""
            }
            
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:])
            }
            
        }
        
        textLabel.setLinksForSubstrings([basic,aspanta], withLinkHandler: handler)
        
    }

    override class func storyboardName() -> String {
        return "About"
    }
}
