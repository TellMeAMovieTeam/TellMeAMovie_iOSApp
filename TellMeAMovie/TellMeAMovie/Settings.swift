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
    var minYear : Int = 0
    var maxYear : Int = 0
    var minRating : Float = 0.0
    var maxRating : Float = 0.0
    
    public init(selectedGenre : Genre, minYear : Int, maxYear : Int, minRating : Float, maxRating : Float) {
        
        self.selectedGenre = selectedGenre
        self.minYear = minYear
        self.maxYear = maxYear
        self.minRating = minRating
        self.maxRating = maxRating
    }
    
    public override init() {
        
        self.selectedGenre = Genre.init()
        self.minYear = 0
        self.maxYear = 0
        self.minRating = 0.0
        self.maxRating = 0.0
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let genreId = aDecoder.decodeInteger(forKey: "TellMeAMovie_Settings_Genre_id")
        let genreName = aDecoder.decodeObject(forKey: "TellMeAMovie_Settings_Genre_name") as! String
        let genre = Genre(genreName: genreName, genreId: genreId)
        
        let minYear = aDecoder.decodeInteger(forKey: "TellMeAMovie_Settings_minYear")
        let maxYear = aDecoder.decodeInteger(forKey: "TellMeAMovie_Settings_maxYear")
        
        let minRating = aDecoder.decodeFloat(forKey: "TellMeAMovie_Settings_minRating")
        let maxRating = aDecoder.decodeFloat(forKey: "TellMeAMovie_Settings_maxRating")
        
        self.init(selectedGenre : genre, minYear : minYear, maxYear : maxYear, minRating : minRating, maxRating : maxRating)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.selectedGenre.genreId, forKey: "TellMeAMovie_Settings_Genre_id")
        aCoder.encode(self.selectedGenre.genreName, forKey: "TellMeAMovie_Settings_Genre_name")
        aCoder.encode(self.minYear, forKey: "TellMeAMovie_Settings_minYear")
        aCoder.encode(self.maxYear, forKey: "TellMeAMovie_Settings_maxYear")
        aCoder.encode(self.minRating, forKey: "TellMeAMovie_Settings_minRating")
        aCoder.encode(self.maxRating, forKey: "TellMeAMovie_Settings_maxRating")
    }
    
    
    /// Сохраняет настройки в UD
    public func saveSettingsToUserDef() {
        
        let settings : Settings = Settings.init(selectedGenre: self.selectedGenre, minYear: self.minYear, maxYear: self.maxYear, minRating: self.minRating, maxRating: self.maxRating)
        /*
        print("saveSettingsToUserDef settings.selectedGenre.genreName \(settings.selectedGenre.genreName)")
        print("saveSettingsToUserDef settings.selectedCountry \(settings.selectedCountry)")
        print("saveSettingsToUserDef settings.minRating \(settings.minRating)")
        print("saveSettingsToUserDef settings.maxRating \(settings.maxRating)")
        print("saveSettingsToUserDef settings.minYear \(settings.minYear)")
        print("saveSettingsToUserDef settings.maxYear \(settings.maxYear)")
        */
        
        let data  = NSKeyedArchiver.archivedData(withRootObject: settings)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey:"TellMeAMovie_Settings" )
        
    }
    
    
    /// Получает и выставляет информацию из UD
    public func getSettingsFromUserDef() {
        
        let decoded  = UserDefaults.standard.object(forKey: "TellMeAMovie_Settings") as! Data
        let decodedSettings = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Settings
        
        /*
        print("getSettingsFromUserDef settings.selectedGenre.genreName \(decodedSettings.selectedGenre.genreName)")
        print("getSettingsFromUserDef settings.selectedCountry \(decodedSettings.selectedCountry)")
        print("getSettingsFromUserDef settings.minRating \(decodedSettings.minRating)")
        print("getSettingsFromUserDef settings.maxRating \(decodedSettings.maxRating)")
        print("getSettingsFromUserDef settings.minYear \(decodedSettings.minYear)")
        print("getSettingsFromUserDef settings.maxYear \(decodedSettings.maxYear)")
        */
        
        self.selectedGenre = decodedSettings.selectedGenre
        self.minYear = decodedSettings.minYear
        self.maxYear = decodedSettings.maxYear
        self.minRating = decodedSettings.minRating
        self.maxRating = decodedSettings.maxRating
        
    }
}
