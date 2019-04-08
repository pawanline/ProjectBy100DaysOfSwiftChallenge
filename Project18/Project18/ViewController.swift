//
//  ViewController.swift
//  Project18
//
//  Created by Pawan Kumar on 08/04/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //print(1,2,3,4,5 , separator: "-")
        
        assert(1 == 1, "Maths failure!")
        assert(1 == 2, "Maths failure!")
        
//        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")

        
        for i in 1...100 {
            print("got number \(i)")
        }
    }


}

