//
//  TermOfUseViewController.swift
//  EmercoinBasic
//

import UIKit

class LegalViewController: BaseTextViewController {
    
    @IBOutlet internal weak var textLabel:FRHyperLabel!
    @IBOutlet internal weak var urlLabel:FRHyperLabel!
    @IBOutlet internal weak var headerLabel:UILabel!
    
    var viewModel:LicenseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    override class func storyboardName() -> String {
        return "Legal"
    }
    
    func updateUI() {
        
        if let viewModel = viewModel {
         
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.left
            
            let font = UIFont.systemFont(ofSize: 15.0)
            let linkAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                  NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle]
            let attributes = [NSForegroundColorAttributeName: UIColor.black,
                              NSFontAttributeName: font]
            
           // let text = String(format:"%@\n\n%@\n\n",viewModel.text, viewModel.url)
            let body = NSMutableAttributedString(string:viewModel.text, attributes: attributes)
            let link = NSMutableAttributedString(string:viewModel.url, attributes: linkAttributes)
    
            headerLabel.text = viewModel.name + " License"
            textLabel.attributedText = body
            urlLabel.attributedText = link
            
            let handler = {
                (hyperLabel: FRHyperLabel?, substring: String?) -> Void in
                
                let url = viewModel.url
                
                if let url = URL(string: url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            
            urlLabel.setLinksForSubstrings([viewModel.url], withLinkHandler: handler)
        }
    }
}

