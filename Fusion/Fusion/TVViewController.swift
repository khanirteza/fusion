
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
