//
//  ViewController.swift
//  Project28
//
//  Created by Pawan Kumar on 04/05/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet var secretTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = "Nothing to see here"
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @IBAction func authenticateTapped(_ sender: Any) {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identifiy Yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        //error
                        let ac = UIAlertController(title: "Authentication Failed", message: "you couldn;t verified please try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Ok", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            
            let ac = UIAlertController(title: "Biometry Unavailable", message: "Your device is not configured for biometric authentication", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
        
        unlockSecretMessage()
    }
    
    
    @objc func adjustKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            secretTextView.contentInset = .zero
        } else {
            secretTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secretTextView.scrollIndicatorInsets = secretTextView.contentInset
        
        let selectedRange = secretTextView.selectedRange
        
        secretTextView.scrollRangeToVisible(selectedRange)
        
        
    }
    
    
    func unlockSecretMessage() {
        secretTextView.isHidden = false
        title = "Secret Stuff!"
        
        if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
            secretTextView.text = text
        }
    }
    
    @objc func saveSecretMessage() {
        guard secretTextView.isHidden == false  else {  return }
        
        KeychainWrapper.standard.set(secretTextView.text, forKey: "SecretMessage")
        secretTextView.resignFirstResponder()
        secretTextView.isHidden = true
        title = "Nothing to see here"
    }
}

