//
//  MainMenuController.swift
//  TellMeAMovie
//
//  Created by Илья on 26.10.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit
import TMDBSwift
import SDWebImage

class MainMenuController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var settingsInMainMenu : Settings = Settings.init()
    private var movies : [Movie] = []
    private var isMoviesDataDownloaded : Bool = false
    
    /// Общее число страниц выдачи с фильмами
    private var totalMoviePages : Int = 0
    
    /// Текущая страница выдачи фильмов
    private var currentMoviesPage : Int = 1
    
    /// Индекс текущего выбраного фильма, индекс жестко связан с данными
    private var currentSelectedMovieIndex : Int = 0
    
    /// Текущий выбранный фильм
    private var currentSelectedMovie : Movie = Movie.init()
    
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
        
        getMoviesWithCurrentSettings(page: 1)
        setMovieToMainMenu(movieIndex: 0)
        
        //setImageFromURL(url: imageBase + movie.poster_path!, imageView: self.moviePoster)
        
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
                previousMovie()
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                nextMovie()
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
       
        print("testFrame")
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FrameCollectionViewCell
        var frameCounter : Int = 0
        if ((isMoviesDataDownloaded == true) && (currentSelectedMovie.framesURLs.count != 0)) {
            
            print(currentSelectedMovie.framesURLs[frameCounter])
            
            cell.frameInit(sringUrl: currentSelectedMovie.framesURLs[frameCounter])
            frameCounter += 1
        }
        
        //cell.backgroundColor = UIColor.black
        // Configure the cell
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth : Float = Float(self.view.frame.size.width - 10)
        let cellHeight : Float = roundf((cellWidth / longSideModifyer) * shortSideModifyer)
        
        return CGSize.init(width: CGFloat(cellWidth), height: CGFloat(cellHeight))
        
    }
    
    /// Получает фильм по заданым параметрам
    ///
    /// - parameter page: Страница выдачи
    private func getMoviesWithCurrentSettings(page : Double) {
        
        settingsInMainMenu.getSettingsFromUserDef()
        
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
        
        self.movies = getMoviesFromUD()
        self.isMoviesDataDownloaded = false
        
        DiscoverMovieMDB.discoverMovies(apikey: TMDb_APIv3_key, language: language, page: page, primary_release_date_gte: year_gte, primary_release_date_lte: year_lte, vote_average_gte: rating_gte, vote_average_lte: rating_lte, with_genres: genre){
            data, movieArr  in
            if let movieArr = movieArr {
                //print("In discover")
                self.totalMoviePages = (data.pageResults?.total_pages)!
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
                            
                            MovieMDB.images(TMDb_APIv3_key, movieID: discoverMovieID, language: "") {
                                data, imgs in
                                if let images = imgs {

                                    var backdropsFilePath : [String] = []
                                    //print("backDrops")
                                    images.backdrops.forEach {
                                        
                                        backdropsFilePath.append(imageBase + $0.file_path!)
                                        //print($0.file_path)
                                    }
                                    //print("Add movie to list")
                                    print("backdropsFilePath")
                                    backdropsFilePath.forEach {
                                    
                                        print($0)
                                    }
                                    
                                    self.movies.append(Movie.init(movie: movie, frames: backdropsFilePath))
                                    
                                    if((movieArr.count - 1) == movieCounter) {
                                        
                                        saveMoviesToUD(movies: self.movies)
                                        self.isMoviesDataDownloaded = true
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
    
    
    /// Выставляет данные фильма в экран
    ///
    /// - parameter movieNumber: Номер сохраненого фильма
    private func setMovieToMainMenu(movieIndex : Int) {
        
        
        if let moviesFromUD : [Movie] = getMoviesFromUD() {
            
            if (moviesFromUD.count != 0) {
                
                let selectedMovie = moviesFromUD[movieIndex]
                
                currentSelectedMovieIndex = movieIndex
                
                self.movieTitle.text = selectedMovie.movieTitle
                self.movieOriginalTitle.text = selectedMovie.movieOriginalTitle
                self.tagLine.text = selectedMovie.movieTagLine
                self.movieGenre.text = selectedMovie.movieGenre
                
                self.movieRating.text = String(describing: selectedMovie.movieRating)
                self.movieOverview.text = selectedMovie.movieOverview
                self.movieYear.text = String(describing: selectedMovie.movieYear)
                
                //TODO обработать кадры и постер
                self.moviePoster.sd_setImage(with: URL.init(string: selectedMovie.moviePoster))
                
                currentSelectedMovie = selectedMovie
                
                self.tableView.reloadData()
                
                self.collectionView.reloadData()
                
                print("frameUrls")
                self.currentSelectedMovie.framesURLs.forEach{
                
                    print($0)
                
                }
                
            }
        }
    }
    
    /// Выставляем предыдущий фильм (свайп слева направо)
    private func previousMovie() {
        
        if (currentSelectedMovieIndex != 0) {
            
            currentSelectedMovieIndex -= 1
            setMovieToMainMenu(movieIndex: currentSelectedMovieIndex)
            
        } else {
            
            //обработка, если сделали свайп до самого начала списка фильмов
            currentSelectedMovieIndex = 0
            setMovieToMainMenu(movieIndex: currentSelectedMovieIndex)
        }
    }
    
    /// Берем следующий фильм (свайп справа налево)
    private func nextMovie() {
        
        // просто берем следующий фильм
        if (currentSelectedMovieIndex < (movies.count - 1)) {
            
            currentSelectedMovieIndex += 1
            setMovieToMainMenu(movieIndex: currentSelectedMovieIndex)
        }
        
        // прошли всю первую страницу выдачи и есть еще страницы выдачи
        if ((currentSelectedMovieIndex == 9) && (currentMoviesPage <= totalMoviePages)) {
            
            currentMoviesPage += 1
            getMoviesWithCurrentSettings(page: Double(currentMoviesPage))
            currentSelectedMovieIndex += 1
            setMovieToMainMenu(movieIndex: currentSelectedMovieIndex)
        }
        
        // если фильмы с таким параметром закончились
        if (currentSelectedMovieIndex == (movies.count - 1) && (currentMoviesPage == totalMoviePages)) {
            
            setMovieToMainMenu(movieIndex: currentSelectedMovieIndex)
            
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
