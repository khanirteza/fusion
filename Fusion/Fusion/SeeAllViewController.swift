//
//  SeeAllViewController.swift
//  
//
//  Created by vamsi krishna reddy kamjula on 8/7/17.
//

import UIKit

class SeeAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mytableView: UITableView!
    
    var urlString: String?
    var MovieDetails = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL.init(string: urlString!)
        let baseUrl = "http://image.tmdb.org/t/p/w780/"
        do {
            let data = try Data.init(contentsOf: url!)
            let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            let results = response["results"] as! [[String:Any]]
            for temp in results {
                let id = temp["id"] as! Double
                let voteAverage = temp["vote_average"] as! Double
                let title = temp["title"] as! String
                let poster = temp["poster_path"] as! String
                let posterurl = baseUrl + poster
                let backdrop = temp["backdrop_path"] as! String
                let backdropurl = baseUrl + backdrop
                let overview = temp["overview"] as! String
                let releaseDate = temp["release_date"] as! String
                MovieDetails.append(["MovieTitle":title, "MovieID":id, "Rating":voteAverage, "MoviePoster":posterurl, "BackdropPoster":backdropurl, "Overview":overview, "Released":releaseDate])
            }
        } catch let err {
            print(err)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieDetails.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        cell.textLabel?.text = MovieDetails[indexPath.row]["MovieTitle"] as? String
        cell.detailTextLabel?.text = MovieDetails[indexPath.row]["Released"] as? String
        
        let url = URL.init(string: (MovieDetails[indexPath.row]["MoviePoster"] as? String)!)
        do {
            let data = try Data.init(contentsOf: url!)
            let image = UIImage.init(data: data)
            cell.imageView?.image = image
        }catch let err {
            print(err)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewCellSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            let indexPath = self.mytableView.indexPathForSelectedRow
            destinationVC.title = MovieDetails[indexPath!.row]["MovieTitle"] as? String
            
            destinationVC.detailArray = MovieDetails[indexPath!.row]
        }
    }
    
}
