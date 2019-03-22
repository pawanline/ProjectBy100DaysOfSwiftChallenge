//
//  Person.swift
//  Project10
//
//  Created by Pawan Kumar on 22/03/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding{
    var name: String
    var image: String
    
    init(name: String, image : String) {
        self.name = name
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.image, forKey: "image")
    }
}
