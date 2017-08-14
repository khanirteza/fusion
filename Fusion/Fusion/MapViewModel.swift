//
//  MapViewModel.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/14/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation
import Alamofire

class MapViewModel{
    
    var theatreDetails = [[String:String]]()
    
    func NetworkCall(urlString:String, compHandler:@escaping([[String:String]])->Void){
        Alamofire.request(urlString).responseJSON{
            response in
            
            let json = response.result.value as! [String:Any]
            print(json)
            if let query = json["query"] as? [String : Any]{
                print(query)
                
                if let results = query["results"] as? [String : Any]{
                let result = results["Result"] as! [[String : Any]]
                for theatre in result{
                    
                    let title = theatre["Title"] as! String
                    let address = theatre["Address"] as! String
                    let city = theatre["City"] as! String
                    let state = theatre["State"] as! String
                    let phone = theatre["Phone"] as! String
                    print(phone)
                    
                    let latitude = theatre["Latitude"] as! String
                    let longitude = theatre["Longitude"] as! String
                    
                    let url = theatre["Url"] as! String
                    
                    let rating = theatre["Rating"] as! [String: Any]
                    let averageRating = rating["AverageRating"] as! String
                    
                    self.theatreDetails.append(["Title":title,"Address":address,"City":city,"State":state,"Phone":phone,"Latitude":latitude,"Longitude":longitude,"Url":url,"AverageRating":averageRating])
                }
                }
                
            }
           compHandler(self.theatreDetails)
        }
    }
}
