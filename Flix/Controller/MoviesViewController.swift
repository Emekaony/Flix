//
//  ViewController.swift
//  Flix
//
//  Created by SHAdON . on 9/16/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var movies = [[String: Any]]()
    var ApiManager = APIManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // print("Hello world!")
        
        var apiKey = ApiManager.getApiKey
        movies = ApiManager.getMovies(apikey: apiKey)["results"] as! [[String: Any]]
        
    }

}

