//
//  MainMenuController.swift
//  TellMeAMovie
//
//  Created by Илья on 26.10.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit
import TMDBSwift

class MainMenuController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBAction func cancelSettingsToMainMenu(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveSettingsToMainMenu(segue:UIStoryboardSegue) {
        
        //TODO: обновление данных
        
    }
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var productionCountry: UILabel!
    
    override func viewDidLoad() {
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        MovieMDB.movie(TMDb_APIv3_key, movieID: 550, language: "en") {
            
            apiReturn, movie in
            if let movie = movie{
                
                print(movie.poster_path)
                
                print(movie.title)
                print(movie.revenue)
                print(movie.genres[0].name)
                print(movie.production_companies?[0].name)
                
                self.movieTitle.text = movie.title
                self.tagLine.text = movie.tagline
                //self.productionCountry.text = movie.production_countries?.count
                self.movieRating.text = String(format: "%.2f", movie.vote_average!)
                
            }
            
            self.tableView.reloadData()
        }
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.black
        
        // Configure the cell
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "FramesCell")
        
        //return CGSize.init(width: (cell?.intrinsicContentSize.width)!, height: (cell?.intrinsicContentSize.height)!)
        
        return CGSize.init(width: 200, height: 200)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }

}
