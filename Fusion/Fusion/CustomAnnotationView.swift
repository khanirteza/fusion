//
//  CustomAnnotationView.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/9/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.image = UIImage(named: "Image.png")
        
        self.canShowCallout = true
        //detailCalloutAccessoryView = UIView()
        self.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
