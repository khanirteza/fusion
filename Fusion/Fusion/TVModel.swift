//
//  TVNetworkCallModel.swift
//  Fusion
//
//  Created by vamsi krishna reddy kamjula on 8/10/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation
import Alamofire

class TVModel {
    var showDetails = [[String:Any]]()
    
    func NetworkCall(urlString:String, compHandler:@escaping([[String:Any]])->Void){
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            self.showDetails.removeAll()
            
            let json = response.result.value as! [String:Any]
            let results = json["results"] as! [[String:Any]]
            for temp in results {
                let id = temp["id"] as! Double
                let voteAverage = temp["vote_average"] as! Double
                let title = temp["name"] as! String
                let poster = temp["poster_path"]!
                let posterurl = "\(baseURL)" + "\(poster)"
                let backdrop = temp["backdrop_path"]!
                let backdropurl = "\(baseURL)" + "\(backdrop)"
                let overview = temp["overview"] as! String
                let firstAirDate = temp["first_air_date"] as! String
                self.showDetails.append(["ShowTitle":title, "ShowID":id, "Rating":voteAverage, "ShowPoster": posterurl, "BackdropPoster": backdropurl,  "Overview":overview, "FirstAired":firstAirDate])
            }
            compHandler(self.showDetails)
        }
    }
}
