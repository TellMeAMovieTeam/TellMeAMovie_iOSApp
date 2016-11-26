//
//  Genre.swift
//  TellMeAMovie
//
//  Created by Илья on 27.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import Foundation

/// Структура для хранения выбранного пользователем жанра
public class Genre : NSObject, NSCoding {
    
    var genreName : String = ""
    var genreId : Int = -1
    
    public init(genreName : String, genreId : Int) {
        
        self.genreName = genreName
        self.genreId = genreId
    }
    
    public override init() {
        self.genreName = ""
        self.genreId = -1
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let genreId = aDecoder.decodeInteger(forKey: "TellMeAMovie_Genre_Id")
        let genreName = aDecoder.decodeObject(forKey: "TellMeAMovie_Genre_Name") as! String
        
        self.init(genreName : genreName, genreId : genreId)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.genreId, forKey: "TellMeAMovie_Genre_Id")
        aCoder.encode(self.genreName, forKey: "TellMeAMovie_Genre_Name")
        
    }
    
}
