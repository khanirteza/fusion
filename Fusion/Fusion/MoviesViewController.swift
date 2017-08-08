//
//  MoviesViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit


class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
 
    var nowPlayingMovieDetails = [[String:Any]]()
    var upcomingMovieDetails = [[String:Any]]()
    var topRatedMovieDetails = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nowPlayingUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToNowPlaying(urlString: nowPlayingUrlString)
        
        let upComingUrlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToUpcoming(urlString: upComingUrlString)
        
        let topRatedUrlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        dataToTopRated(urlString: topRatedUrlString)
        
        userPhotoImageView.image = UserDataProvider.getUserPhoto()
        
    }
    
    func dataToTopRated(urlString: String) {
        let url = URL.init(string: urlString)
        let baseUrl = "http://image.tmdb.org/t/p/w780/"
        do {
            let data = try Data.init(contentsOf: url!)
            let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            let results = response["results"] as! [[String:Any]]
            for temp in results {
                let id = temp["id"] as! Double
                let voteAverage = temp["vote_average"] as! Double
                let title = temp["title"] as! String
                let poster = temp["poster_path"] as! String
                let posterurl = baseUrl + poster
                let backdrop = temp["backdrop_path"] as! String
                let backdropurl = baseUrl + backdrop
                let overview = temp["overview"] as! String
                let releaseDate = temp["release_date"] as! String
                topRatedMovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
        } catch let err {
            print(err)
        }
    }
    
    func dataToUpcoming(urlString: String) {
        let url = URL.init(string: urlString)
        let baseUrl = "http://image.tmdb.org/t/p/w780/"
        do {
            let data = try Data.init(contentsOf: url!)
            let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            let results = response["results"] as! [[String:Any]]
            for temp in results {
                let id = temp["id"] as! Double
                let voteAverage = temp["vote_average"] as! Double
                let title = temp["title"] as! String
                let poster = temp["poster_path"] as! String
                let posterurl = baseUrl + poster
                let backdrop = temp["backdrop_path"] as! String
                let backdropurl = baseUrl + backdrop
                let overview = temp["overview"] as! String
                let releaseDate = temp["release_date"] as! String
                upcomingMovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
        } catch let err {
            print(err)
        }
    }
    
    func dataToNowPlaying(urlString: String) {
        let url = URL.init(string: urlString)
        let baseUrl = "http://image.tmdb.org/t/p/w780/"
        do {
            let data = try Data.init(contentsOf: url!)
            let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            let results = response["results"] as! [[String:Any]]
            for temp in results {
                let id = temp["id"] as! Double
                let voteAverage = temp["vote_average"] as! Double
                let title = temp["title"] as! String
                let poster = temp["poster_path"] as! String
                let posterurl = baseUrl + poster
                let backdrop = temp["backdrop_path"] as! String
                let backdropurl = baseUrl + backdrop
                let overview = temp["overview"] as! String
                let releaseDate = temp["release_date"] as! String
                nowPlayingMovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
        } catch let err {
            print(err)
        }
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == nowPlayingCollectionView {
            return 3
        }
        if collectionView == upcomingCollectionView {
            return 3
        }
        return 3
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
        } else {
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
    }
}
