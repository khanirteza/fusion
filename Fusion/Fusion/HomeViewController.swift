//
//  HomeViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import CoreData
import CoreLocation
var zipCode = ""
class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    var locationManager = CLLocationManager()
    
    //let logNotification = "loggedInUser"

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        userPhotoImageView.image = UserDataProvider.getUserPhoto()
        
    }
    
    //get the zip code
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.last!, completionHandler: {(placemark, error) -> Void in
            if error == nil && placemark!.count > 0{
                print(placemark![0].postalCode!)
                zipCode = placemark![0].postalCode!
                
            }
        })
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
