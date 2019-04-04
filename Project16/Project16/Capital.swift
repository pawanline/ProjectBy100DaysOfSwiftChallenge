//
//  Capital.swift
//  Project16
//
//  Created by Pawan Kumar on 03/04/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject,MKAnnotation {

    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var url : String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String,url: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.url = url
    }
}
