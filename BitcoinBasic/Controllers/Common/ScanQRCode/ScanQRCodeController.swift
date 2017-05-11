//
//  ScanQRCodeController.swift
//  EmercoinBasic
//

import UIKit
import AVFoundation
import QRCodeReader

class ScanQRCodeController: BaseViewController {
    
    var scanned:((_ data:AnyObject) -> (Void))?

    lazy var reader = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
        $0.showTorchButton = true
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.loadScanner()
        }
    }
    
    private func loadScanner() {
        
        do {
            if try QRCodeReader.supportsMetadataObjectTypes() {
                reader.modalPresentationStyle = .formSheet
                reader.modalTransitionStyle = .crossDissolve
                reader.delegate               = self
                
                reader.completionBlock = { (result: QRCodeReaderResult?) in
                    if let result = result {
                        print("Completion with result: \(result.value) of type \(result.metadataType)")
                    }
                }
                
                present(reader, animated: true, completion: nil)
            }
        } catch let error as NSError {
            switch error.code {
            case -11852:
                let alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true, completion: nil)
            case -11814:
                let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true, completion: nil)
            default:()
            }
        }
    }
}

extension ScanQRCodeController : QRCodeReaderViewControllerDelegate {
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
    
            QRCodeHelper.parseScanedText(result: result.value, completion: { data, success in
                let alert = UIAlertController(
                    title: "",
                    message: String (format:"QR-Code is incorrect"),
                    preferredStyle: .alert
                )
                // alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                if !success! {
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        self?.dismiss(animated: true, completion: nil)
                    }))
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    self?.scanned?(data!)
                    self?.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
        dismiss(animated: true) { 
            self.parent?.dismiss(animated: true, completion: nil)
        }
    }
}
