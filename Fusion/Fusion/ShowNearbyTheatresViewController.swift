//
//  ShowNearbyTheatresViewController.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/9/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

import MapKit
import CoreData
import CoreLocation

class ShowNearbyTheatresViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    
    var theatreDetails = [[String:String]]()
    var zipCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsPointsOfInterest = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        locationManager.delegate = self
        
        
        guard let userZip = UserDataProvider.getUserZipCode() else{
            requestAuthorization()
            return
        }
        zipCode = userZip
        fetchTheatreLocations()
        
        
    }
    
    
    func fetchTheatreLocations(){
        theatreDetails.removeAll()
        print(zipCode)
        
        let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D%27\(zipCode)%27%20and%20query%3D%27movie_theatre%27&format=json&callback="
        
        
        let modal = MapViewModel()
        
        modal.NetworkCall(urlString: urlString) {
            details in
            
           self.theatreDetails = details
            
            if self.theatreDetails.count == 0{
                let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed, Try After Sometime!", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(ac, animated : true)
            }
            self.showLocations()
            self.tableView.reloadData()
        }
        
        
//        //                let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D%2760070%27%20and%20query%3D%27movie_theatre%27&format=json&callback="
//        //        print(zipCode)
//
//        let url = URL(string: urlString)!
//        print(zipCode)
//        print(url)
//
//        do{
//            let data = try Data.init(contentsOf: url)
//
//            //parsing the data
//            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
//
//            print(json)
//            if let query = json["query"] as? [String : Any]{
//            print(query)
//
//            let results = query["results"] as! [String : Any]
//            let result = results["Result"] as! [[String : Any]]
//            for theatre in result{
//
//                let title = theatre["Title"] as! String
//                let address = theatre["Address"] as! String
//                let city = theatre["City"] as! String
//                let state = theatre["State"] as! String
//                let phone = theatre["Phone"] as! String
//                print(phone)
//                //let phone = "7732172181"
//
//                let latitude = theatre["Latitude"] as! String
//                let longitude = theatre["Longitude"] as! String
//
//                let url = theatre["Url"] as! String
//                
//                let rating = theatre["Rating"] as! [String: Any]
//                let averageRating = rating["AverageRating"] as! String
//
//                theatreDetails.append(["Title":title,"Address":address,"City":city,"State":state,"Phone":phone,"Latitude":latitude,"Longitude":longitude,"Url":url,"AverageRating":averageRating])
//            }
//            }
//
//        }catch let error{
//            print(error)
//        }
//
//        showLocations()
//        tableView.reloadData()
//
    }
    
    
    func showLocations(){
        for i in 0..<theatreDetails.count{
            let theatre = theatreDetails[i]
            let latitude = theatre["Latitude"]
            let longitude = theatre["Longitude"]
            
            let coordinates = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(latitude!)!, longitude: CLLocationDegrees(longitude!)!)
            
            let span = MKCoordinateSpanMake(0.1, 0.1)
            
            let theatreLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(latitude!)!, CLLocationDegrees(longitude!)!)
            
            
            let region: MKCoordinateRegion = MKCoordinateRegionMake(theatreLocation, span)
            
            self.mapView.setRegion(region, animated: true)
            
            let annotation = AnnotationDetails(coordinates: coordinates,title: theatre["Title"]!,
                                               address: theatre["Address"]!, city: theatre["City"]!, state: theatre["State"]!, phone: theatre["Phone"]!, url: theatre["Url"]!,averageRating:theatre["AverageRating"]!)
            
            mapView.addAnnotation(annotation)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theatre = theatreDetails[indexPath.row]
        let latitude = theatreDetails[indexPath.row]["Latitude"]
        let longitude = theatreDetails[indexPath.row]["Longitude"]
        let coordinates = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(latitude!)!, longitude: CLLocationDegrees(longitude!)!)
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(latitude!)!, CLLocationDegrees(longitude!)!)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        
        let annotation = AnnotationDetails(coordinates: coordinates,title: theatre["Title"]!,
                                           address: theatre["Address"]!, city: theatre["City"]!, state: theatre["State"]!, phone: theatre["Phone"]!, url: theatre["Url"]!,averageRating:theatre["AverageRating"]!)
        
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let pin = CustomAnnotationView(annotation: annotation, reuseIdentifier: "pin1")
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "showTheatreDetailSegue", sender: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTheatreDetailSegue" {
            let dest = segue.destination as! TheatreDetails
            let view = sender as! CustomAnnotationView
            let annotation = view.annotation as! AnnotationDetails
            
            dest.title = annotation.title!
            dest.address = annotation.address!
            dest.city = annotation.city!
            dest.state = annotation.state!
            dest.phone = annotation.phone!
            dest.url = annotation.url!
            dest.averageRating = annotation.averageRating!
            
        }
        
    }
    
    func requestAuthorization()
    {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    @IBAction func currentLocation(_ sender: UIButton) {
        
       requestAuthorization()
        
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(locations.last!, completionHandler: {(placemark, error) -> Void in
            if error == nil && placemark!.count > 0{
                print(placemark![0].postalCode!)
                self.zipCode = placemark![0].postalCode!
                self.fetchTheatreLocations()
                
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theatreDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theatreTableViewCell", for: indexPath)
        
        let theatre = theatreDetails[indexPath.row]
        
        cell.textLabel?.text = theatre["Title"]
        cell.detailTextLabel?.text = theatre["Address"]
        
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
