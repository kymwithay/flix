//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Kymberlee Hill on 2/2/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, respone, error) in
            
            //this will run when network request returns
            
            if let error = error{
                print(error.localizedDescription)
                
            }else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                for movies in movies{
                    let title = movies["title"] as! String
                    print(title)
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ _tableView: UITableView,numberOfRowsInSection section: Int) ->
        Int{
            return 10
    }
    func tableView(_ _tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
