//
//  WalletProtectionEncryptActivityView.swift
//  EmercoinBasic
//

import UIKit

class WalletProtectionEncryptActivityView: PopupView {

    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var progressBarView:UIProgressView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    var checkEncrypt:((Void) -> (Void))?
    
    private var seconds = 0
    private var interval = 120
    private var current = 0
    
    private var timer:Timer?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        startTimer(at:interval)
    }
    
    func startTimer(at seconds:Int) {
        
        self.seconds = seconds
        
        if interval != seconds {
            interval = seconds
        }
        
        activityIndicator.isHidden = true
        current = 0
        progressBarView.progress = 0
        
        let selector = #selector(self.updateUI)
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:selector, userInfo: nil, repeats: true)
        
        self.timer = timer
        timer.fire()
    }

    func updateUI() {
        
        current += 1
        seconds -= 1
        
        let progress =  Float(current) / Float(interval)
        progressBarView.setProgress(Float(progress), animated: true)
        
        let min = seconds / 60
        let sec = seconds >= 60 ? seconds - 60 : seconds
        
        timeLabel.text = String(format:"%02d:%02d",min,sec)
        
        if seconds == 0 {
            if let timer = timer {
                timer.invalidate()
                self.timer = nil
            }
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            if checkEncrypt != nil {
                checkEncrypt!()
            }
        }
    }
}
