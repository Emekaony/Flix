//
//  APIManager.swift
//  Flix
//
//  Created by SHAdON . on 9/16/22.
//

import Foundation

struct APIManager {
    
    let APIKey: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    func getMovies(apikey: String) -> [String: Any] {
        
        // initialize it so xcode doesn't cry
        var dataDictionary = [String: Any]()
        
        let url = URL(string: APIKey)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                 
             }
        }
        task.resume()
        
        return dataDictionary
    }
    
    var getApiKey: String {
        return self.APIKey
    }
    
}
