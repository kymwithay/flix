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
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellsPerLine: CGFloat = 3
        let addedHeaderAndLeftSpacing:CGFloat = 20
        let interItemSpacingTotal = (layout.minimumInteritemSpacing + addedHeaderAndLeftSpacing) * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal/cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
            cell.posterImageView.af_setImage(withURL: posterUrl)
            cell.posterImageView.layer.cornerRadius = 10.0
        }
        
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell) {
            let movie = movies[indexPath.item]
            let detailViewController = segue.destination as! DetailSuperHeroViewController
            detailViewController.movie = movie
        }
        
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
    
}
