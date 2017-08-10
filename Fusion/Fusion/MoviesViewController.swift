//
//  MoviesViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import Alamofire

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var mostPopularCollectionView: UICollectionView!
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
 
    var nowPlayingMovieDetails = [[String:Any]]()
    var upcomingMovieDetails = [[String:Any]]()
    var topRatedMovieDetails = [[String:Any]]()
    var mostPopularMovieDetails = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nowPlayingUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToNowPlaying(urlString: nowPlayingUrlString)
        
        let upComingUrlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToUpcoming(urlString: upComingUrlString)
        
        let topRatedUrlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToTopRated(urlString: topRatedUrlString)
        
        let mostPopularString = "https://api.themoviedb.org/3/movie/popular?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToMostPopular(urlString: mostPopularString)
        
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
                let title = temp["title"] as! String
                let poster = temp["poster_path"] as! String
                let posterurl = baseURL + poster
                let backdrop = temp["backdrop_path"] as! String
                let backdropurl = baseURL + backdrop
                let overview = temp["overview"] as! String
                let releaseDate = temp["release_date"] as! String
                self.mostPopularMovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
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
                let title = temp["title"] as! String
                let poster = temp["poster_path"] as! String
                let posterurl = baseURL + poster
                let backdrop = temp["backdrop_path"] as! String
                let backdropurl = baseURL + backdrop
                let overview = temp["overview"] as! String
                let releaseDate = temp["release_date"] as! String
                self.topRatedMovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
            DispatchQueue.main.async {
                self.topRatedCollectionView.reloadData()
            }
        }
    }
    
    func dataToUpcoming(urlString: String) {
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            
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
                self.upcomingMovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
            DispatchQueue.main.async {
                self.upcomingCollectionView.reloadData()
            }
        }
    }
    
    func dataToNowPlaying(urlString: String) {
        Alamofire.request(urlString).responseJSON{
            response in
            
            let baseURL = "http://image.tmdb.org/t/p/w780/"
            
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
                self.nowPlayingMovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
            DispatchQueue.main.async {
                self.nowPlayingCollectionView.reloadData()
            }
        }
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == nowPlayingCollectionView {
            return nowPlayingMovieDetails.count
        }
        if collectionView == upcomingCollectionView {
            return upcomingMovieDetails.count
        }
        if collectionView == topRatedCollectionView {
            return topRatedMovieDetails.count
        }
        return mostPopularMovieDetails.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == nowPlayingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlaying", for: indexPath)
            
            let movie = nowPlayingMovieDetails[indexPath.row]
            
            let posterImage = cell.viewWithTag(1) as! UIImageView
            let urlImage = URL.init(string: movie["MoviePoster"] as! String)
            do {
                let data = try Data.init(contentsOf: urlImage!)
                let image = UIImage.init(data: data)
                posterImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        } else if collectionView == upcomingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath)
            let movie = upcomingMovieDetails[indexPath.row]
            
            let posterImage = cell.viewWithTag(2) as! UIImageView
            let urlImage = URL.init(string: movie["MoviePoster"] as! String)
            do {
                let data = try Data.init(contentsOf: urlImage!)
                let image = UIImage.init(data: data)
                posterImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        } else if collectionView ==  topRatedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRated", for: indexPath)
            let movie = topRatedMovieDetails[indexPath.row]
            
            let posterImage = cell.viewWithTag(3) as! UIImageView
            let urlImage = URL.init(string: movie["MoviePoster"] as! String)
            do {
                let data = try Data.init(contentsOf: urlImage!)
                let image = UIImage.init(data: data)
                posterImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mostPopular", for: indexPath)
            let movie = mostPopularMovieDetails[indexPath.row]
            
            let posterImage = cell.viewWithTag(4) as! UIImageView
            let urlImage = URL.init(string: movie["MoviePoster"] as! String)
            do {
                let data = try Data.init(contentsOf: urlImage!)
                let image = UIImage.init(data: data)
                posterImage.image = image
            }catch let err {
                print(err)
            }
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nowPlayingSeeAll" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "Now Playing"
            destinationVC.urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "upcomingSeeAll" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "Upcoming"
            destinationVC.urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "topRatedSeeAll" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "Top Rated"
            destinationVC.urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "mostPopularSeeAll" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "Most Popular"
            destinationVC.urlString = "https://api.themoviedb.org/3/movie/popular?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "nowPlayingDetails" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.nowPlayingCollectionView.indexPath(for: cell!)
            
            destinationVC.title = nowPlayingMovieDetails[indexPath!.row]["MovieTitle"] as? String
            destinationVC.detailArray = nowPlayingMovieDetails[indexPath!.row]
        }
        if segue.identifier == "upcomingDetails" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.upcomingCollectionView.indexPath(for: cell!)
            destinationVC.title = upcomingMovieDetails[indexPath!.row]["MovieTitle"] as? String
            destinationVC.detailArray = upcomingMovieDetails[indexPath!.row]
        }
        if segue.identifier == "topRatedDetails" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.topRatedCollectionView.indexPath(for: cell!)
            destinationVC.title = topRatedMovieDetails[indexPath!.row]["MovieTitle"] as? String
            destinationVC.detailArray = topRatedMovieDetails[indexPath!.row]
        }
        if segue.identifier == "mostPopularDetails" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.mostPopularCollectionView.indexPath(for: cell!)
            destinationVC.title = mostPopularMovieDetails[indexPath!.row]["MovieTitle"] as? String
            destinationVC.detailArray = mostPopularMovieDetails[indexPath!.row]
        }
    }
}
