//
//  Movie.swift
//  TellMeAMovie
//
//  Created by Илья on 27.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import Foundation
import TMDBSwift
import Realm
import RealmSwift


public class RealmStringObject : Object {
    dynamic var value : String = ""
    
}

//TODO переделать под realm
public class Movie : Object {
    
    dynamic var movieId : Int = 0
    dynamic var movieTitle : String = ""
    dynamic var movieOriginalTitle : String = ""
    dynamic var movieRating : Double = 0
    dynamic var movieTagLine : String = ""
    dynamic var movieOverview : String = ""
    dynamic var moviePoster : String = ""
    dynamic var movieGenre : String = ""
    dynamic var movieYear : Int = 0
    
    //для более удобного хранения в UD
    var framesURLs = List<RealmStringObject>()
    
    public func setData(movie : MovieDetailedMDB, frames : [RealmStringObject]) {
        
        movie.id != nil ? (self.movieId = movie.id!) : (self.movieId = -1)
        movie.title != nil ? (self.movieTitle = movie.title!) : (self.movieTitle = "")
        movie.original_title != nil ? (self.movieOriginalTitle = movie.original_title!) : (self.movieOriginalTitle = "")
        movie.vote_average != nil ? (self.movieRating = movie.vote_average!) : (self.movieRating = -1)
        movie.tagline != nil ? (self.movieTagLine = movie.tagline!) : (self.movieTagLine = "")
        movie.overview != nil ? (self.movieOverview = movie.overview!) : (self.movieOverview = "")
        movie.poster_path != nil ? (self.moviePoster = imageBase + movie.poster_path!) : (self.moviePoster = "")
        
        self.movieGenre = getSingleLineGenres(movie: movie)
        
        movie.release_date != nil ? ( self.movieYear = Int((movie.release_date?.substring(to: (movie.release_date?.index((movie.release_date?.endIndex)!, offsetBy: -6))!))!)!) : (self.movieYear = 0)
        
        
        frames.count != 0 ? (self.framesURLs.append(objectsIn: frames)) : (self.framesURLs = List<RealmStringObject>())
    }
    
    public func setData() {
        
        self.movieId = -1
        self.movieTitle = ""
        self.movieOriginalTitle = ""
        self.movieRating = -1
        self.movieTagLine = ""
        self.movieOverview = ""
        self.moviePoster = ""
        self.movieGenre = ""
        self.movieYear = 0
        
        self.framesURLs = List<RealmStringObject>()
    }
    
    public func setData(id : Int, title : String, originalTitle : String, voteAverage : Double, tagline : String, overview : String, moviePoster : String, movieGenre : String, movieYear : Int, frames : [RealmStringObject]) {
        
        self.movieId = id
        self.movieTitle = title
        self.movieOriginalTitle = originalTitle
        self.movieRating = voteAverage
        self.movieTagLine = tagline
        self.movieOverview = overview
        self.moviePoster = moviePoster
        self.movieGenre = movieGenre
        self.movieYear = movieYear
        
        self.framesURLs.append(objectsIn: frames)
    }
}

public func saveMoviesToUD(movies : [Movie]) {
    
    let realm = try! Realm()
    
    let objects = List<Movie>()
    movies.forEach {
        objects.append($0)
    }
    
    try! realm.write {
        realm.add(objects)
    }
    
}

public func getMoviesFromUD() -> [Movie] {
    
    let objects = try! Realm().objects(Movie)
    
    let array = Array(objects)
    
    return array
}

public func removeMoviesFromUD(movies : [Movie]) {
    
    let objects = List<Movie>()
    movies.forEach {
        objects.append($0)
    }
    
    let realm = try! Realm()
    try! realm.write {
        realm.delete(objects)
    }
}

public func removeMoviesFromUD() {
    
    let realm = try! Realm()
    try! realm.write {
        realm.deleteAll()
    }
}

