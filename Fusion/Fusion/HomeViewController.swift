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
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    
    //let logNotification = "loggedInUser"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userPhotoImageView.image = UserDataProvider.getUserPhoto()
        print(MiscDataProvider.TMDB_API_Key)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
