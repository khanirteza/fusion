//
//  ShowNearbyTheatresViewController.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/9/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

import MapKit

class ShowNearbyTheatresViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var theatreDetails = [[String:String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsPointsOfInterest = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        
        
        fetchTheatreLocations()
        
        
    }
    
    
    func fetchTheatreLocations(){
        
        print(zipCode)
        let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D%27\(zipCode)%27%20and%20query%3D%27movie_theatre%27&format=json&callback="
//        //        let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D%2720770%27%20and%20query%3D%27movie_theatre%27&format=json&diagnostics=true&callback="
        //        print(zipCode)
        let url = URL(string: urlString)

        do{
            let data = try Data.init(contentsOf: url!)

            //parsing the data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]

           // print(json)
            let query = json["query"] as! [String : Any]

            let results = query["results"] as! [String : Any]
            let result = results["Result"] as! [[String : Any]]
            for theatre in result{

                let title = theatre["Title"] as! String
                let address = theatre["Address"] as! String
                let city = theatre["City"] as! String
                let state = theatre["State"] as! String
                let phone = theatre["Phone"] as! String
                print(phone)
                //let phone = "7732172181"

                let latitude = theatre["Latitude"] as! String
                let longitude = theatre["Longitude"] as! String

                theatreDetails.append(["Title":title,"Address":address,"City":city,"State":state,"Phone":phone,"Latitude":latitude,"Longitude":longitude])
            }

        }catch let error{
            print(error)
        }

        showLocations()
    }
    
    func showLocations(){
        for i in 0..<theatreDetails.count{
            let theatre = theatreDetails[i]
            let latitude = theatre["Latitude"]
            let longitude = theatre["Longitude"]
            
            let coordinates = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(latitude!)!, longitude: CLLocationDegrees(longitude!)!)
            
            let span = MKCoordinateSpanMake(0.2, 0.2)
            
            let theatreLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(latitude!)!, CLLocationDegrees(longitude!)!)
            
            
            let region: MKCoordinateRegion = MKCoordinateRegionMake(theatreLocation, span)
            
            self.mapView.setRegion(region, animated: true)
            
            let annotation = AnnotationDetails(coordinates: coordinates,title: theatre["Title"]!,
                                               address: theatre["Address"]!, city: theatre["City"]!, state: theatre["State"]!, phone: theatre["Phone"]!)
            
            mapView.addAnnotation(annotation)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = CustomAnnotationView(annotation: annotation, reuseIdentifier: "pin1")
        return pin
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
