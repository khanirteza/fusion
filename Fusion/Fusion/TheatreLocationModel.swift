//
//  TheatreLocationModel.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/11/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation

class TheatreLocationModel{
    
    var theatreLocations = [[String : String]]()
    func fetchTheatreDetails(url : URL, theatreDetails : @escaping([[String : String]])->Void){
        
        do{
            let data = try Data.init(contentsOf: url)
            
            //parsing the data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
            
            print(json)
            let query = json["query"] as! [String : Any]
            
            let results = query["results"] as! [String : Any]
            let result = results["Result"] as! [[String : Any]]
            for theatre in result{
                
                let title = theatre["Title"] as! String
                let address = theatre["Address"] as! String
                let city = theatre["City"] as! String
                let state = theatre["State"] as! String
               // let phone = theatre["Phone"] as! String
                let phone = "7732172181"
                
                let latitude = theatre["Latitude"] as! String
                let longitude = theatre["Longitude"] as! String
                
                theatreLocations.append(["Title":title,"Address":address,"City":city,"State":state,"Phone":phone,"Latitude":latitude,"Longitude":longitude])
            }
            
        }catch let error{
            print(error)
        }
        theatreDetails(self.theatreLocations)
        
    }
}
