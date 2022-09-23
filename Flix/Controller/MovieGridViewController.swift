//
//  MovieGridViewController.swift
//  Flix
//
//  Created by SHAdON . on 9/23/22.
//

import UIKit

class MovieGridViewController: UIViewController {
    
    /*
     In real life, it is often the case that every screen starts with a network call like this
     A call to an API performed in the viewDidLoad() mehtod!
     */
    
    
    var movies = [[String: Any]]()
    var apikey = "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: apikey)!
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
                 print(self.movies)
                
             }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
