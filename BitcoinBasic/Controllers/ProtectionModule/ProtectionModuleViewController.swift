//
//  ProtectionModuleViewController.swift
//  EmercoinBasic
//

import UIKit

class ProtectionModuleViewController: BaseViewController {

    @IBOutlet internal weak var mainView:UIView!
    @IBOutlet var constraints: [NSLayoutConstraint]!
    
    private var words:[String] = []
    
    private weak var generationView:ProtectionGenerationView!
    private weak var validationView:ProtectionValidationView!
    
    override class func storyboardName() -> String {
        return "ProtectionModule"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        if isIphone5() {
            constraints.forEach({ (constraint) in
                constraint.constant -= 20
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction internal func startButtonPressed() {
        
        showGenerationView()
    }
    
    private func showGenerationView() {
        
        let view = getProtectionView(at: 0) as! ProtectionGenerationView
     
        view.nextPressed = { [weak self] in
            
            if self?.words.count == 8 {
                self?.showValidationView()
                view.removeFromSuperview()
            } else {
                self?.generateWord()
            }
        }
        
        view.startOverPressed = { [weak self] in
            
            self?.words.removeAll()
            self?.generateWord()
        }
        
        self.mainView.addSubview(view)
        self.generationView = view
        generateWord()
    }
    
    private func showValidationView() {
        
        let view = getProtectionView(at: 1) as! ProtectionValidationView
        
        view.nextPressed = { [weak self] in
            self?.showDoneView()
            view.removeFromSuperview()
        }
        
        view.startOverPressed = { [weak self] in
            
            self?.words.removeAll()
            self?.showGenerationView()
            self?.validationView.removeFromSuperview()
        }
        
        view.enterText = {[weak self] text in
            
            view.isValide = (self?.validateWords(at: text))!
        }
        
        self.mainView.addSubview(view)
        self.validationView = view
    }
    
    private func showDoneView() {
        let view = getProtectionView(at: 2) as! ProtectionDoneView
        
        view.done = { [weak self] in
            view.removeFromSuperview()
            self?.back()
        }
        
        self.mainView.addSubview(view)
    }
    
    private func generateWord() {
        
        let word = GenerationWordsHelper.generateWord()
        
        if words.contains(word) {
            generateWord()
        } else {
            if generationView != nil {
                words.append(word)
                generationView.word = word
                generationView.count = words.count
            }
        }
    }
    
    private func getProtectionView(at index:Int) -> UIView {
        return loadViewFromXib(name: "ProtectionModule", index: index, frame: mainView.bounds)
    }
    
    private func validateWords(at text:String) -> Bool {

        var result = false
        
        let enteredWords = text.components(separatedBy: " ")
        
        if enteredWords.count == 8 {
            
            for word in enteredWords {
                result = words.contains(word.lowercased())
                if result == false {
                    break
                }
            }
        }
        return result
    }
}
