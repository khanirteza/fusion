//
//  TheatreDetailsViewController.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/10/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

class TheatreDetailsViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    @IBOutlet weak var urlButton: UIButton!
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
        urlButton.setTitle(url, for: .normal)
        ratingsLabel.text = averageRating
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showUrl(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! WebViewController
        let view = sender as! UIButton
        destVC.urlString = view.title(for: .normal)
    }
}
