//
//  Settings.swift
//  TellMeAMovie
//
//  Created by Илья on 26.11.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import Foundation

/// Структура, которая хранит в себе все основыне данные о настройках
public class Settings : NSObject, NSCoding {
    
    var selectedGenre : Genre
    var selectedCountry : String = ""
    var minYear : Int = 0
    var maxYear : Int = 0
    var minRating : Float = 0.0
    var maxRating : Float = 0.0
    
    public init(selectedGenre : Genre, selectedCountry : String, minYear : Int, maxYear : Int, minRating : Float, maxRating : Float) {
        
        self.selectedGenre = selectedGenre
        self.selectedCountry = selectedCountry
        self.minYear = minYear
        self.maxYear = maxYear
        self.minRating = minRating
        self.maxRating = maxRating
    }
    
    public override init() {
        
        self.selectedGenre = Genre.init()
        self.selectedCountry = ""
        self.minYear = 0
        self.maxYear = 0
        self.minRating = 0.0
        self.maxRating = 0.0
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let genreId = aDecoder.decodeInteger(forKey: "TellMeAMovie_Settings_Genre_id")
        let genreName = aDecoder.decodeObject(forKey: "TellMeAMovie_Settings_Genre_name") as! String
        let genre = Genre(genreName: genreName, genreId: genreId)
        
        let country = aDecoder.decodeObject(forKey: "TellMeAMovie_Settings_selectedCountry") as! String
        
        let minYear = aDecoder.decodeInteger(forKey: "TellMeAMovie_Settings_minYear")
        let maxYear = aDecoder.decodeInteger(forKey: "TellMeAMovie_Settings_maxYear")
        
        let minRating = aDecoder.decodeFloat(forKey: "TellMeAMovie_Settings_minRating")
        let maxRating = aDecoder.decodeFloat(forKey: "TellMeAMovie_Settings_maxRating")
        
        self.init(selectedGenre : genre, selectedCountry : country, minYear : minYear, maxYear : maxYear, minRating : minRating, maxRating : maxRating)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.selectedGenre.genreId, forKey: "TellMeAMovie_Settings_Genre_id")
        aCoder.encode(self.selectedGenre.genreName, forKey: "TellMeAMovie_Settings_Genre_name")
        aCoder.encode(self.selectedCountry, forKey: "TellMeAMovie_Settings_selectedCountry")
        aCoder.encode(self.minYear, forKey: "TellMeAMovie_Settings_minYear")
        aCoder.encode(self.maxYear, forKey: "TellMeAMovie_Settings_maxYear")
        aCoder.encode(self.minRating, forKey: "TellMeAMovie_Settings_minRating")
        aCoder.encode(self.maxRating, forKey: "TellMeAMovie_Settings_maxRating")
    }
    
    public func saveSettingsToUserDef() {
        
        let settings : Settings = Settings.init(selectedGenre: self.selectedGenre, selectedCountry: self.selectedCountry, minYear: self.minYear, maxYear: self.maxYear, minRating: self.minRating, maxRating: self.maxRating)
        
        let data  = NSKeyedArchiver.archivedData(withRootObject: settings)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey:"TellMeAMovie_Settings" )
        
    }
    
    public func getSettingsFromUSerDef() {
        
        let decoded  = UserDefaults.standard.object(forKey: "TellMeAMovie_Settings") as! Data
        let decodedSettings = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Settings
        
        self.selectedGenre = decodedSettings.selectedGenre
        self.selectedCountry = decodedSettings.selectedCountry
        self.minYear = decodedSettings.minYear
        self.maxYear = decodedSettings.maxYear
        self.minRating = decodedSettings.minRating
        self.maxRating = decodedSettings.maxRating
        
    }
}
