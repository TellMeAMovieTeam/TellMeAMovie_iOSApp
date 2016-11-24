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
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func viewDidLoad() {
        
        tableView.estimatedRowHeight = 540
        tableView.rowHeight = UITableViewAutomaticDimension
        
        MovieMDB.movie(TMDb_APIv3_key, movieID: 550, language: "ru") {
            
            apiReturn, movie in
            if let movie = movie{
                
                print(movie.poster_path)
                
                print(movie.title)
                print(movie.revenue)
                print(movie.genres[0].name)
                print(movie.production_companies?[0].name)
                
                self.movieTitle.text = movie.title
                self.tagLine.text = movie.tagline
                
                print(movie.production_countries?[0].name)
                
                self.movieRating.text = String(format: "%.2f", movie.vote_average!)
                self.movieOverview.text = movie.overview
                
                setImageFromURL(url: imageBase + movie.poster_path!, imageView: self.moviePoster)
            }
            
            self.tableView.reloadData()
        }
        
        let posterCell = tableView.dequeueReusableCell(withIdentifier: "PosterCell")
        
        //posterCell?.frame.height = 400
        
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
        
        let cellWidth = self.view.frame.size.width - 10
        
        return CGSize.init(width: cellWidth, height: 200)
        
        //return CGSize.init(width: 200, height: 200)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 1 && indexPath.row == 0) {
        
            return 500
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
}
