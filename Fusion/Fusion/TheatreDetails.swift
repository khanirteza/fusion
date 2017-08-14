//
//  TheatreDetails.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/14/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

class TheatreDetails: UIViewController {
    
    
    @IBOutlet weak var urlButtonOutlet: UIButton!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var address:String?
    var city : String?
    var state : String?
    var phone : String?
    var url : String?
    var averageRating : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLabel.text = address
        cityLabel.text = city
        stateLabel.text = state
        phoneLabel.text = phone
        ratingsLabel.text = averageRating
        urlButtonOutlet.setTitle(url, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func urlButtonAction(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let destVC = segue.destination as! ShowWebView
                let view = sender as! UIButton
            destVC.title = self.title
                destVC.urlString = view.title(for: .normal)
        
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
