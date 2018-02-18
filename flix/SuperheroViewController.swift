//
//  SuperheroViewController.swift
//  flix
//
//  Created by Kymberlee Hill on 2/13/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        fetchMoviesData()
        
    }
    
    func collectionView(_ _collectionview: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ _collectionview: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String{
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: baseUrlString + posterPathString)!
            print(posterUrl)
            cell.posterImageView.af_setImage(withURL: posterUrl)
            cell.posterImageView.layer.cornerRadius = 10.0
        }
        
        return cell
        
    }
    func fetchMoviesData() {
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
                self.movies = movies
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

