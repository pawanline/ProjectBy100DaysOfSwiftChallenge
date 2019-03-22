//
//  Person.swift
//  Project10
//
//  Created by Pawan Kumar on 22/03/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit

class Person: NSObject, Codable{
    var name: String
    var image: String
    
    init(name: String, image : String) {
        self.name = name
        self.image = image
    }
    
}
