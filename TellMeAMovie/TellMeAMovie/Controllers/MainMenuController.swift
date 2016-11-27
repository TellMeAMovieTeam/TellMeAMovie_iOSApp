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
    
    var settingsInMainMenu : Settings = Settings.init()
    
    @IBAction func cancelSettingsToMainMenu(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveSettingsToMainMenu(segue:UIStoryboardSegue) {
        
        if let settingsMenuController = segue.source as? SettingsMenuController {
            
            settingsInMainMenu = settingsMenuController.settingsFromSettingsMenu
            settingsInMainMenu.minYear = Int(settingsMenuController.labelStartYear.text!)!
            settingsInMainMenu.maxYear = Int(settingsMenuController.labelEndYear.text!)!
            
            settingsInMainMenu.minRating = Float(settingsMenuController.labelRatingMin.text!)!
            settingsInMainMenu.maxRating = Float(settingsMenuController.labelRatingMax.text!)!
            
            settingsInMainMenu.saveSettingsToUserDef()
        }
        //TODO: обновление данных
        
    }
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOriginalTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var productionCountry: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    let longSideModifyer : Float = 16.0
    let shortSideModifyer : Float = 9.0
    var frameNumber : Int = 5
    
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
                self.movieOriginalTitle.text = movie.original_title
                self.tagLine.text = movie.tagline
                self.movieGenre.text = getSingleLineGenres(movie: movie)
                
                print(movie.production_countries?[0].name)
                
                self.movieRating.text = String(format: "%.2f", movie.vote_average!)
                self.movieOverview.text = movie.overview
                self.movieYear.text = movie.release_date?.substring(to: (movie.release_date?.index((movie.release_date?.endIndex)!, offsetBy: -6))!)
                
                setImageFromURL(url: imageBase + movie.poster_path!, imageView: self.moviePoster)
            }
            
            self.tableView.reloadData()
        }
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameNumber
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.black
        
        // Configure the cell
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth : Float = Float(self.view.frame.size.width - 10)
        let cellHeight : Float = roundf((cellWidth / longSideModifyer) * shortSideModifyer)
        
        return CGSize.init(width: CGFloat(cellWidth), height: CGFloat(cellHeight))
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 2 && indexPath.row == 0) {
            
            let cellWidth : Float = Float(self.view.frame.size.width - 16) //16 так как два констрейнта по 8
            let cellHeight : Float = roundf((cellWidth / shortSideModifyer) * longSideModifyer)
            
            return CGFloat(cellHeight)
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
}
