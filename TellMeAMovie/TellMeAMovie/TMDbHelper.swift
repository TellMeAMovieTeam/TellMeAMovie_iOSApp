//
//  TMDbHelper.swift
//  TellMeAMovie
//
//  Created by Илья on 23.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import Foundation

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