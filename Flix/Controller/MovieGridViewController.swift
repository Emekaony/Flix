//
//  MovieGridViewController.swift
//  Flix
//
//  Created by SHAdON . on 9/23/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController {
    
    /*
     In real life, it is often the case that every screen starts with a network call like this
     A call to an API performed in the viewDidLoad() mehtod!
     */
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String: Any]]()
    var apikey = "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        // here is how you access the width of the phone
        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * (3/2))
        
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
                 self.collectionView.reloadData()
                
             }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // collection views have items and not indexes so this is tricky
        if segue.identifier == "gridToDetail" {
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)!
            
            print(indexPath.item)
            
            let movie = movies[indexPath.item]
            
            let destinationVC = segue.destination as! MovieDetailsViewController
            destinationVC.movie = movie
        }
    }

}

extension MovieGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        // collectionView's have items and not rows
        let movie = movies[indexPath.item]
        // print(indexPath.item)
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterViewPath = movie["poster_path"] as! String
        let posterViewUrl = URL(string: baseUrl+posterViewPath)
        
        cell.posterView.af.setImage(withURL: posterViewUrl!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
