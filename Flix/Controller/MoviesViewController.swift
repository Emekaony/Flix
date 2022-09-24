//
//  ViewController.swift
//  Flix
//
//  Created by SHAdON . on 9/16/22.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController {
    
    var movies = [[String: Any]]()
    var ApiManager = APIManager()
    let APIKey: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: APIKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                    
                 self.movies = dataDictionary["results"] as! [[String: Any]]
                 // print(movies)
                 
                 self.tableView.reloadData()
                 
             }
        }
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // write code to prepare for the next screen
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let movie = movies[indexPath.row]
        
        let detailVC = segue.destination as! MovieDetailsViewController
        detailVC.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

//MARK: - Tableview customisation

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // when using storyboards, you give your cells identifiers so you can do things like this below
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell

        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl+posterPath)
        
        cell.posterReview.af.setImage(withURL: posterUrl!)
        cell.posterReview.contentMode = .scaleAspectFill
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        cell.synopsisLabel.numberOfLines = 0
        cell.posterReview.clipsToBounds = true
        
        return cell
    }
    
}

