
//
//  TVViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 7/30/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit



class TVViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    var popularTVShows = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show user image on top right
        userPhotoImageView.image = UserDataProvider.getUserPhoto()
        
        fetchPopularTVShows()
    }
    
    func fetchPopularTVShows(){
        
        let popularUrlString = "https://api.themoviedb.org/3/tv/popular?api_key=90b6573b1ed4a6ccaf1a5749ca8bfd46&language=en-US&page=1"
        let url = URL(string: popularUrlString)
        
        
        
        do{
              let data = try Data.init(contentsOf: url!)
            
            //parsing the data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
            
            let results = json["results"] as! [[String : Any]]
            
            for item in results{
                let id = item["id"] as! Int
                let name = item["name"] as! String
                let vote_average = item["vote_average"] as! Double
                let poster_path = item["poster_path"] as! String
                let overview = item["overview"] as! String
                
                let tvShow = ["id" : id, "name" : name, "vote_average" : vote_average,"poster_path" : "http://image.tmdb.org/t/p/w780"+poster_path,"overview":overview ] as [String : Any]
                popularTVShows.append(tvShow)
            }
                
            
        }catch let error{
            print(error)
        }
        print(popularTVShows.count)
    }//method ends here
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularTVShows.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTVShowCellID", for: indexPath)
        let show = popularTVShows[indexPath.row]
        let imageUrl = URL(string: show["poster_path"] as! String)
        
        let showImage = cell.viewWithTag(1) as! UIImageView
        do {
            let data = try Data(contentsOf: imageUrl!)
            let image = UIImage.init(data: data)
            showImage.image = image
        }catch let err {
            print(err)
        }
        return cell
        
    }
    
    @IBAction func SeeAllPopularTVShows(_ sender: UIButton) {
        
        performSegue(withIdentifier: "TVShowSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! TVShowsTableViewController
        dest.popularShows = popularTVShows
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
