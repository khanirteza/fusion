//
//  DetailsViewController.swift
//  Fusion
//
//  Created by vamsi krishna reddy kamjula on 8/8/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var wallPosterImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var detailArray = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        releasedLabel.text = "Released: \(detailArray["Released"] as! String)"
        ratingLabel.text = "Rating: \(detailArray["Rating"] as! Double)"
        overviewLabel.text = detailArray["Overview"] as? String
        overviewLabel.numberOfLines = 0
        
        let posterUrl = URL.init(string: (detailArray["MoviePoster"] as! String))
        let wallPosterUrl = URL.init(string: detailArray["BackdropPoster"] as! String)
        do {
            let posterData = try Data.init(contentsOf: posterUrl!)
            let wallPosterData = try Data.init(contentsOf: wallPosterUrl!)
            let Image1 = UIImage.init(data: posterData)
            let Image2 = UIImage.init(data: wallPosterData)
            posterImage.image = Image1
            wallPosterImage.image = Image2
        }catch let err {
            print(err)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
