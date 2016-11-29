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
    
    private var settingsInMainMenu : Settings = Settings.init()
    private var movies : [Movie] = []
    private var isMoviesDataDownloaded : Bool = false
    
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
        settingsInMainMenu.getSettingsFromUserDef()
        
        MovieMDB.movie(TMDb_APIv3_key, movieID: 550, language: language) {
            
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
                
                self.movieRating.text = String(format: "%.2f", movie.vote_average!)
                self.movieOverview.text = movie.overview
                self.movieYear.text = movie.release_date?.substring(to: (movie.release_date?.index((movie.release_date?.endIndex)!, offsetBy: -6))!)
                
                setImageFromURL(url: imageBase + movie.poster_path!, imageView: self.moviePoster)
            }
            
            self.tableView.reloadData()
        }
        settingsInMainMenu.getSettingsFromUserDef()
        getMoviesWithCurrentSettings()
        
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            default:
                break
            }
        }
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
    
    private func getMoviesWithCurrentSettings() {
        
        //MARK : Year checking
        var year_gte : String = ""
        var year_lte : String = ""
        
        if (settingsInMainMenu.minYear == 0) {
            
            year_gte = "1950-01-01"
            
        } else {
            
            year_gte = String(settingsInMainMenu.minYear) + "-01-01"
        }
        
        if (settingsInMainMenu.maxYear == 0) {
            
            year_lte = String(getCurrentYear()) + "-01-01"
            
        } else {
            
            year_lte = String(settingsInMainMenu.maxYear) + "-01-01"
        }
        
        //MARK : Genre
        var genre : String? = nil
        if (settingsInMainMenu.selectedGenre.genreId == -1 ) {
            
            genre = nil
            
        } else {
            
            genre = String(settingsInMainMenu.selectedGenre.genreId)
        }
        
        //MARK : Rating
        var rating_gte : Double = 0
        var rating_lte : Double = 0
        
        if (settingsInMainMenu.minRating == 0) {
            
            rating_gte = 0
        } else {
            
            rating_gte = Double(settingsInMainMenu.minRating)
        }
        
        if (settingsInMainMenu.maxRating == 0) {
            
            rating_lte = 10
        } else {
            
            rating_lte = Double(settingsInMainMenu.maxRating)
        }
        
        var movieCounter = 0;
        
        DiscoverMovieMDB.discoverMovies(apikey: TMDb_APIv3_key, language: language, page: 1, primary_release_date_gte: year_gte, primary_release_date_lte: year_lte, vote_average_gte: rating_gte, vote_average_lte: rating_lte, with_genres: genre){
            data, movieArr  in
            if let movieArr = movieArr {
                print("In discover")
                movieArr.forEach {
                    
                    print($0.id)
                    print($0.title)
                    print($0.original_title)
                    //по id фильма находим его кадры и полную информацию
                    var discoverMovieID: Int = $0.id!
                    
                    MovieMDB.movie(TMDb_APIv3_key, movieID: discoverMovieID, language: language) {
                        //получили информацию о фильме
                        apiReturn, movie in
                        if let movie = movie {
                            
                            MovieMDB.images(TMDb_APIv3_key, movieID: discoverMovieID, language: language) {
                                data, imgs in
                                if let images = imgs {
                                    
                                    var stillsFilePath : [String] = []
                                    var backdropsFilePath : [String] = []
                                    
                                    images.stills.forEach {
                                        stillsFilePath.append($0.file_path!)
                                    }
                                    
                                    images.backdrops.forEach {
                                    
                                        backdropsFilePath.append($0.file_path!)
                                    }
                                    print("Add movie to list")
                                    self.movies.append(Movie.init(movie: movie, frames: backdropsFilePath))
                                    
                                    if((movieArr.count - 1) == movieCounter) {
                                    
                                        saveMoviesToUD(movies: self.movies)
                                        self.isMoviesDataDownloaded = true
                                        
                                        print("getMoviesFromUD")
                                        var test : [Movie] = getMoviesFromUD()
                                        print(test[0].movieTitle)
                                    }
                                    
                                    movieCounter += 1
                                }
                            }
                        }
                    }
                    
                }
            }
            
        }
        
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
