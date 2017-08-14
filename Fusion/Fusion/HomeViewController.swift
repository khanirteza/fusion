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


class HomeViewController: UIViewController {
    
    //let logNotification = "loggedInUser"
    @IBOutlet weak var tableViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigationBar()
//        guard let watchlist = DataModel.getWatchlist() else{
//            print("nothing in the watchlist")
//            return
//        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setNavigationBar(){
        let userProfilePhoto = UserDataProvider.getUserPhoto()
        
        let userProfileButtonView = UIImageView(frame: CGRect(x: 0, y: 150, width: 40, height: 40))
        userProfileButtonView.contentMode = .scaleAspectFit
        userProfileButtonView.image = userProfilePhoto
        let userPhotoButton = UIBarButtonItem(customView: userProfileButtonView)
        navigationItem.rightBarButtonItem = userPhotoButton
    }
    
}
