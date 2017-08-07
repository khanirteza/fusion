
//
//  TVViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

class TVViewController: UIViewController {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userPhotoImageView.image = UserDataProvider.getUserPhoto()
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
