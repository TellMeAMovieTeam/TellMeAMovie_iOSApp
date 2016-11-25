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

public let imageBase = "https://image.tmdb.org/t/p/w500"

/// Структура для хранения выбранного пользователем жанра
public struct Genre {
    
    var genreName : String = ""
    var genreId : Int = -1
    
    init(genreName : String, genreId : Int) {
        
        self.genreName = genreName
        self.genreId = genreId
    }
    
}

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
