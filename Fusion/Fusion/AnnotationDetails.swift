//
//  AnnotationDetails.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/9/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import MapKit

class AnnotationDetails: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    
    var title: String?
    var address: String?
    var city : String?
    var state: String?
    var phone : String?
    var url : String?
    var averageRating : String?
    
    init(coordinates: CLLocationCoordinate2D, title: String, address:String, city:String,state:String,phone:String,url: String,averageRating:String){
        self.coordinate = coordinates
        self.title = title
        self.subtitle = address
        self.address = address
        self.city = city
        self.state = state
        self.phone = phone
        self.url = url
        self.averageRating = averageRating
        
        super.init()
    }
}
