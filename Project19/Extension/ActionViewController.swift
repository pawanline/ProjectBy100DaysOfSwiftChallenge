//
//  ActionViewController.swift
//  Extension
//
//  Created by Pawan Kumar on 12/04/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {


    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict,error) in 
                    guard let itemDictionary = dict as? NSDictionary else {
                        return
                    }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    print(javaScriptValues)
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageUrl = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }

    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey:argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }

}
