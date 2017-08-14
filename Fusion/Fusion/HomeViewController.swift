//
//  HomeViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import CoreData


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //let logNotification = "loggedInUser"
    @IBOutlet weak var tableViewController: UITableView!
    
    var details = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let watchlist = DataModel.getWatchlist()
        details.removeAll()
        for temp in watchlist! {
            
            let modal = WatchLaterDetails.init()
            
            modal.NetworkCall(urlString: "https://api.themoviedb.org/3/movie/\(temp)?api_key=" + MiscDataProvider.TMDB_API_Key + "&language=en-US") {
                showDetails in
                
                self.details.append(contentsOf: showDetails)
                self.tableViewController.reloadData()
            }
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        cell.textLabel?.text = details[indexPath.row]["Title"] as! String
        cell.detailTextLabel?.text = details[indexPath.row]["Released"] as! String
        return cell
    }
    
    
}
