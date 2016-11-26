//
//  TMDbHelper.swift
//  TellMeAMovie
//
//  Created by Илья on 23.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import Foundation
import TMDBSwift

public let TMDb_APIv3_key : String = "a21fd90cc71c8a7e7cdd53aa432f5c07"

public let minimalYear : Int = 1950

public let imageBase = "https://image.tmdb.org/t/p/w500"

public func getSingleLineGenres(movie: MovieMDB) -> String {

    let genresCount : Int = movie.genres.count
    var genresStr : String = ""
    
    if (genresCount == 1) {
        genresStr = movie.genres[0].name!
        return genresStr
    }
    
    movie.genres.forEach {
    
        genresStr += $0.name!
        genresStr += ", "
    }
    
    //удаляем два последних элемента в строке с жанрами 
    genresStr = String(genresStr.characters.dropLast(2))
    print(genresStr)
    
    return genresStr

}

public func getCurrentYear() -> Int {
    
    let date = Date()
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    
    return year

}
