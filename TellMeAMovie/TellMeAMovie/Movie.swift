//
//  Movie.swift
//  TellMeAMovie
//
//  Created by Илья on 27.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import Foundation
import TMDBSwift

public class Movie  {
    
    var movieId : Int = 0
    var movieTitle : String = ""
    var movieOriginalTitle : String = ""
    var movieRating : Double = 0
    var movieTagLine : String = ""
    var productionCountry : String = ""
    var movieOverview : String = ""
    var moviePoster : String = ""
    var movieGenre : String = ""
    var movieYear : Int = 0
    
    //для более удобного хранения в UD
    var framesURLs : [String] = []
    
    public init(movie : MovieDetailedMDB, frames : [String]) {
        
        self.movieId = movie.id!
        self.movieTitle = movie.title!
        self.movieOriginalTitle = movie.original_title!
        self.movieRating = movie.vote_average!
        self.movieTagLine = movie.tagline
        self.productionCountry = (movie.production_countries?[0].name)!
        self.movieOverview = movie.overview!
        self.moviePoster = imageBase + movie.poster_path!
        self.movieGenre = getSingleLineGenres(movie: movie)
        self.movieYear = Int((movie.release_date?.substring(to: (movie.release_date?.index((movie.release_date?.endIndex)!, offsetBy: -6))!))!)!
        
        frames.forEach {
        
            self.framesURLs.append(imageBase + $0)
        
        }
        
    }
    
    
    public init(id : Int, title : String, originalTitle : String, voteAverage : Double, tagline : String, productionCountry : String, overview : String, moviePoster : String, movieGenre : String, movieYear : Int, frames : [String]) {
    
        self.movieId = id
        self.movieTitle = title
        self.movieOriginalTitle = originalTitle
        self.movieRating = voteAverage
        self.movieTagLine = tagline
        self.productionCountry = productionCountry
        self.movieOverview = overview
        self.moviePoster = moviePoster
        self.movieGenre = movieGenre
        self.movieYear = movieYear
        
        self.framesURLs = frames
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        
        let id = aDecoder.decodeInteger(forKey: "TellMeAMovie_Movie_Id")
        let title = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_title") as! String
        let originalTitle = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_originalTitle") as! String
        let voteAverage = aDecoder.decodeDouble(forKey: "TellMeAMovie_Movie_voteAverage")
        let tagline = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_tagline") as! String
        let productionCountry = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_productionCountry") as! String
        let overview = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_overview") as! String
        let moviePoster = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_moviePoster") as! String
        let movieGenre = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_movieGenre") as! String
        let movieYear = aDecoder.decodeInteger(forKey: "TellMeAMovie_Movie_movieYear")
        let frames : [String] = aDecoder.decodeObject(forKey: "TellMeAMovie_Movie_frames") as! [String]
        
        self.init(id : id, title : title, originalTitle : originalTitle, voteAverage : voteAverage, tagline : tagline, productionCountry : productionCountry, overview : overview, moviePoster : moviePoster, movieGenre : movieGenre, movieYear : movieYear, frames : frames)
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.movieId, forKey: "TellMeAMovie_Movie_Id")
        aCoder.encode(self.movieTitle, forKey: "TellMeAMovie_Movie_title")
        aCoder.encode(self.movieOriginalTitle, forKey: "TellMeAMovie_Movie_originalTitle")
        aCoder.encode(self.movieRating, forKey: "TellMeAMovie_Movie_voteAverage")
        aCoder.encode(self.movieTagLine, forKey: "TellMeAMovie_Movie_tagline")
        aCoder.encode(self.movieGenre, forKey: "TellMeAMovie_Movie_productionCountry")
        aCoder.encode(self.movieOverview, forKey: "TellMeAMovie_Movie_overview")
        aCoder.encode(self.moviePoster, forKey: "TellMeAMovie_Movie_moviePoster")
        aCoder.encode(self.movieGenre, forKey: "TellMeAMovie_Movie_movieGenre")
        aCoder.encode(self.movieYear, forKey: "TellMeAMovie_Movie_movieYear")
        aCoder.encode(self.framesURLs, forKey: "TellMeAMovie_Movie_frames")
        
    }
    
}

public func saveMoviesToUD(movies : [Movie]) {

    let userDefaults = UserDefaults.standard
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: movies)
    userDefaults.set(encodedData, forKey: "TellMeAMovie_Movies")
    userDefaults.synchronize()

}

public func getMoviesFromUD() -> [Movie] {
    
    if let decoded  = UserDefaults.standard.object(forKey: "TellMeAMovie_Movies") as! Data? {
        let decodedMovies = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Movie]
        
        return decodedMovies
    }
    return []
    
}


