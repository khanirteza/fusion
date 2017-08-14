//
//  WatchLaterDetails.swift
//  Fusion
//
//  Created by vamsi krishna reddy kamjula on 8/14/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation
import Alamofire

class WatchLaterDetails {
    var Details = [[String:Any]]()
    
    func NetworkCall(urlString:String, compHandler:@escaping([[String:Any]])->Void){
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            self.Details.removeAll()
            
            let json = response.result.value as! [String:Any]
            let backdrop = json["backdrop_path"] as! String
            let backdropurl = "\(baseURL)" + "\(backdrop)"
            let title = json["original_title"] as! String
            let overview = json["overview"] as! String
            let poster = json["poster_path"] as! String
            let posterurl = "\(baseURL)" + "\(poster)"
            let releaseDate = json["release_date"] as! String
            let rating = json["vote_average"] as! Double
            
            self.Details.append(["Title":title, "Rating":rating, "Poster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            
            compHandler(self.Details)
        }
    }
}
