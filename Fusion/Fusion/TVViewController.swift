
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
        setNavigationBar()
        
        let modal = TVModel.init()
        
        modal.NetworkCall(urlString: "https://api.themoviedb.org/3/tv/on_the_air?api_key=" + MiscDataProvider.TMDB_API_Key + "&language=en-US&page=1") {
            onTheAirDetails in
            
            self.OnTheAirShowDetails.append(contentsOf: onTheAirDetails)
            self.onTheAirCollectionView?.reloadData()
        }
        
        modal.NetworkCall(urlString: "https://api.themoviedb.org/3/tv/airing_today?api_key=" + MiscDataProvider.TMDB_API_Key + "&language=en-US&page=1") {
            willOnTheAirDetails in
            
            self.WillBeOnAirShowDetails.append(contentsOf: willOnTheAirDetails)
            self.willBeOnAirCollectionView.reloadData()
        }
        
        modal.NetworkCall(urlString: "https://api.themoviedb.org/3/tv/top_rated?api_key=" + MiscDataProvider.TMDB_API_Key + "&language=en-US&page=1") {
            topRatedDetails in
            
            self.TopRatedShowDetails.append(contentsOf: topRatedDetails)
            self.topRatedCollectionView?.reloadData()
        }
        
        modal.NetworkCall(urlString: "https://api.themoviedb.org/3/tv/popular?api_key=" + MiscDataProvider.TMDB_API_Key + "&language=en-US&page=1") {
            mostPopularDetails in
            
            self.MostPopularShowDetails.append(contentsOf: mostPopularDetails)
            self.mostPopularCollectionView?.reloadData()
        }
        
        userPhotoImageView.image = UserDataProvider.getUserPhoto()
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
            let url = URL.init(string: OnTheAirShowDetails[indexPath.row]["Poster"] as! String)
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
            let imageString = WillBeOnAirShowDetails[indexPath.row]["Poster"] as! String
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
            let url = URL.init(string: TopRatedShowDetails[indexPath.row]["Poster"] as! String)
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
            let url = URL.init(string: MostPopularShowDetails[indexPath.row]["Poster"] as! String)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OnTVSeeAllSegue" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "On TV"
            destinationVC.x = false
            destinationVC.urlString = "https://api.themoviedb.org/3/tv/on_the_air?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "Next7DaysSeeAllSegue" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "Next 7 Days"
            destinationVC.x = false
            destinationVC.urlString = "https://api.themoviedb.org/3/tv/airing_today?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "TVTopRatedSeeAllSegue" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "Top Rated"
            destinationVC.x = false
            destinationVC.urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "TVMostPopularSeeAllSegue" {
            let destinationVC = segue.destination as! SeeAllViewController
            destinationVC.title = "Top Rated"
            destinationVC.x = false
            destinationVC.urlString = "https://api.themoviedb.org/3/tv/popular?api_key=38c202b89452edcd18696b9e9962f08a&language=en-US&page=1"
        }
        if segue.identifier == "OnTheAirDetailSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.onTheAirCollectionView.indexPath(for: cell!)
            destinationVC.x = false
            
            destinationVC.title = OnTheAirShowDetails[indexPath!.row]["Title"] as? String
            destinationVC.detailArray = OnTheAirShowDetails[indexPath!.row]
        }
        if segue.identifier == "Next7DaysDetailSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.willBeOnAirCollectionView.indexPath(for: cell!)
            destinationVC.x = false
            
            destinationVC.title = WillBeOnAirShowDetails[indexPath!.row]["Title"] as? String
            destinationVC.detailArray = WillBeOnAirShowDetails[indexPath!.row]
        }
        if segue.identifier == "TVTopRatedDetailSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.topRatedCollectionView.indexPath(for: cell!)
            destinationVC.x = false
            
            destinationVC.title = TopRatedShowDetails[indexPath!.row]["Title"] as? String
            destinationVC.detailArray = TopRatedShowDetails[indexPath!.row]
        }
        if segue.identifier == "TVMostPopularDetailSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            let cell = sender as? UICollectionViewCell
            let indexPath = self.mostPopularCollectionView.indexPath(for: cell!)
            destinationVC.x = false
            
            destinationVC.title = MostPopularShowDetails[indexPath!.row]["Title"] as? String
            destinationVC.detailArray = MostPopularShowDetails[indexPath!.row]
        }
    }
    
    func setNavigationBar(){
        let userProfilePhoto = UserDataProvider.getUserPhoto()
        
        let userProfileButtonView = UIImageView(frame: CGRect(x: 0, y: 150, width: 40, height: 40))
        userProfileButtonView.contentMode = .scaleAspectFit
        userProfileButtonView.image = userProfilePhoto
        let userPhotoButton = UIBarButtonItem(customView: userProfileButtonView)
        navigationItem.rightBarButtonItem = userPhotoButton
    }
}
