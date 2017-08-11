//
//  NetworkCallModel.swift
//  Fusion
//
//  Created by vamsi krishna reddy kamjula on 8/10/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import Foundation
import Alamofire

class MoviesModel {
    var movieDetails = [[String:Any]]()
    
    func NetworkCall(urlString:String, compHandler:@escaping([[String:Any]])->Void){
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            self.movieDetails.removeAll()
            
            let json = response.result.value as! [String:Any]
            let results = json["results"] as! [[String:Any]]
            for temp in results {
                let id = temp["id"] as! Double
                let voteAverage = temp["vote_average"] as! Double
                let title = temp["title"] as! String
                let poster = temp["poster_path"] as! String
                let posterurl = baseURL + poster
                let backdrop = temp["backdrop_path"] as! String
                let backdropurl = baseURL + backdrop
                let overview = temp["overview"] as! String
                let releaseDate = temp["release_date"] as! String
                self.movieDetails.append(["Title":title, "ID":id, "Rating":voteAverage, "Poster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
            compHandler(self.movieDetails)
        }
    }
}
