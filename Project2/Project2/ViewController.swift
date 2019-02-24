//
//  ViewController.swift
//  Project2
//
//  Created by Pawan Kumar on 19/02/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var scrore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia","france","germancy","ireland","italy","monace","nigeria","poland","russia","spain","uk","us"]
        
        self.button1.layer.borderColor = UIColor.lightGray.cgColor
        self.button2.layer.borderColor = UIColor.lightGray.cgColor
        self.button3.layer.borderColor = UIColor.lightGray.cgColor
        
        self.button1.layer.borderWidth = 1.0
        self.button2.layer.borderWidth = 1.0
        self.button3.layer.borderWidth = 1.0

        askQuestions()
        
        
    }
    
    func askQuestions() {
        self.button1.setImage(UIImage(named: countries[0]), for: .normal)
        self.button2.setImage(UIImage(named: countries[1]), for: .normal)
        self.button3.setImage(UIImage(named: countries[2]), for: .normal)
    }


}

