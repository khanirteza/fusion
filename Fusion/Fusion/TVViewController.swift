
//
//  TVViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import Alamofire

class TVViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var willBeOnAirCollectionView: UICollectionView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var onTheAirCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var mostPopularCollectionView: UICollectionView!
    
    var OnTheAirShowDetails = [[String:Any]]()
    var WillBeOnAirShowDetails = [[String:Any]]()
    var TopRatedShowDetails = [[String:Any]]()
    var MostPopularShowDetails = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onTheAirUrlString = "https://api.themoviedb.org/3/tv/on_the_air?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToOnTheAir(urlString: onTheAirUrlString)
        
        let willBeOnAirUrlString = "https://api.themoviedb.org/3/tv/airing_today?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToWillBeOnAir(urlString: willBeOnAirUrlString)
        
        let topRatedUrlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToTopRated(urlString: topRatedUrlString)
        
        let mostPopularUrlString = "https://api.themoviedb.org/3/tv/popular?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToMostPopular(urlString: mostPopularUrlString)
        
        userPhotoImageView.image = UserDataProvider.getUserPhoto()
    }
    
    func dataToMostPopular(urlString: String) {
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            
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
                self.MostPopularShowDetails.append(["ShowTitle":title, "ShowID":id, "Rating":voteAverage, "ShowPoster": posterurl, "BackdropPoster": backdropurl,  "Overview":overview, "FirstAired":firstAirDate])
            }
            DispatchQueue.main.async {
                self.mostPopularCollectionView.reloadData()
            }
        }
    }
    
    func dataToTopRated(urlString: String) {
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            
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
                self.TopRatedShowDetails.append(["ShowTitle":title, "ShowID":id, "Rating":voteAverage, "ShowPoster": posterurl, "BackdropPoster": backdropurl,  "Overview":overview, "FirstAired":firstAirDate])
            }
            DispatchQueue.main.async {
                self.topRatedCollectionView.reloadData()
            }
        }
    }
    
    func dataToWillBeOnAir(urlString: String) {
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            
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
                self.WillBeOnAirShowDetails.append(["ShowTitle":title, "ShowID":id, "Rating":voteAverage, "ShowPoster": posterurl, "BackdropPoster": backdropurl,  "Overview":overview, "FirstAired":firstAirDate])
            }
            DispatchQueue.main.async {
                self.willBeOnAirCollectionView.reloadData()
            }
        }
    }
    
    func dataToOnTheAir(urlString: String) {
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            
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
                self.OnTheAirShowDetails.append(["ShowTitle":title, "ShowID":id, "Rating":voteAverage, "ShowPoster": posterurl, "BackdropPoster": backdropurl,  "Overview":overview, "FirstAired":firstAirDate])
            }
            DispatchQueue.main.async {
                self.onTheAirCollectionView.reloadData()
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == onTheAirCollectionView {
            return OnTheAirShowDetails.count
        } else if collectionView == willBeOnAirCollectionView {
            return WillBeOnAirShowDetails.count
        } else if collectionView == topRatedCollectionView {
            return TopRatedShowDetails.count
        } else {
            return MostPopularShowDetails.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == onTheAirCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onTheAir", for: indexPath)
            
            let airImage = cell.viewWithTag(1) as! UIImageView
            let url = URL.init(string: OnTheAirShowDetails[indexPath.row]["ShowPoster"] as! String)
            do {
                let data = try Data.init(contentsOf: url!)
                let image = UIImage.init(data: data)
                airImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        } else if collectionView == willBeOnAirCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "willBeOnAir", for: indexPath)
            let airImage = cell.viewWithTag(2) as! UIImageView
            let imageString = WillBeOnAirShowDetails[indexPath.row]["ShowPoster"] as! String
            let url = URL.init(string: imageString)
            do {
                let data = try Data.init(contentsOf: url!)
                let image = UIImage.init(data: data)
                airImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        } else if collectionView == topRatedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRated", for: indexPath)
            let airImage = cell.viewWithTag(3) as! UIImageView
            let url = URL.init(string: TopRatedShowDetails[indexPath.row]["ShowPoster"] as! String)
            do {
                let data = try Data.init(contentsOf: url!)
                let image = UIImage.init(data: data)
                airImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mostPopular", for: indexPath)
            let airImage = cell.viewWithTag(4) as! UIImageView
            let url = URL.init(string: MostPopularShowDetails[indexPath.row]["ShowPoster"] as! String)
            do {
                let data = try Data.init(contentsOf: url!)
                let image = UIImage.init(data: data)
                airImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        }
    }
}
