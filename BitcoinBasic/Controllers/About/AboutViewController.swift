//
//  AboutViewController.swift
//  EmercoinBasic
//

import UIKit

let aboutText = "«Emercoin Basic» is a thin client for Emercoin Core Wallet which is connecting via RPC protocol designed by Aspanta Limited. \n\n«Emercoin» is one of the world's leading digital currency and blockchain platforms. Emercoin allows users to exchange money and valuable information, anywhere in the world, at any time, quickly, securely and affordably. Emercoin is a digital currency that uses the power of blockchain technology to provide the most secure way to send, receive and store money. A blockchain is a distributed database where cryptography is used to ensure that records can not be changed. The Emercoin blockchain allows you to store, send and receive money anywhere in the world. When you control your money, you decide when to send it. No one can charge you money, nor can they spend your money when you use Emercoin. International payments now take minutes, not days. Using Emercoin is extremely affordable. You can securely send any amount of money at any time, anywhere for pennies. The Emercoin blockchain is a safer way to send money than a bank because of the superior technology that gives control back to the owner. Emercoin is much more than money, it is information. You can securely store, send and receive ownership and identity information, register censorship-resistant domain names and browse the internet without having to use passwords anymore! These services are available 24/7 on the Emercoin blockchain. When you use Emercoin, you are the sole owner of your money and this means there is no third party who can lose track of your information. No one can steal your identity or impersonate you when using Emercoin, and you can choose how much information you reveal to someone when you send them money or information.\n\n«Aspanta Limited» is an expert in the development of highly loaded web and mobile full-cycle applications, reliable Microsoft Azure cloud resources, decentralized systems based on the Emercoin blockchain."

class AboutViewController: BaseTextViewController {

    @IBOutlet internal weak var textLabel:FRHyperLabel!
    
    private var basicLink = "https://www.emercoin.net/basic"
    private var emerLink = "https://www.emercoin.net"
    private var aspantaLink = "https://www.aspanta.com"
    
    private var basic = "«Emercoin Basic»"
    private var emer = "«Emercoin»"
    private var aspanta = "«Aspanta Limited»"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        let font = UIFont.systemFont(ofSize: 15.0)
        
        let attributes = [NSForegroundColorAttributeName: UIColor.black,
                          NSFontAttributeName: font]
        
        textLabel.attributedText = NSAttributedString(string: aboutText, attributes: attributes)
        
        let handler = {[weak self]
            (hyperLabel: FRHyperLabel?, substring: String?) -> Void in
            
            var url = ""
            
            if substring == self?.basic {
                url = self?.basicLink ?? ""
            } else if substring == self?.emer {
                url = self?.emerLink ?? ""
            } else if substring == self?.aspanta {
                url = self?.aspantaLink ?? ""
            }
            
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:])
            }
            
        }
        
        textLabel.setLinksForSubstrings([basic, emer, aspanta], withLinkHandler: handler)
        
    }

    override class func storyboardName() -> String {
        return "About"
    }
}
