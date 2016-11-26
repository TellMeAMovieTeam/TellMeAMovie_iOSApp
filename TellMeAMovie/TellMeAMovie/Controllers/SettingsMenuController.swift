//
//  SettingsMenuController.swift
//  TellMeAMovie
//
//  Created by Илья on 26.10.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit
import YSRangeSlider

class SettingsMenuController: UITableViewController {
    
    @IBOutlet weak var detailGenre: UILabel!
    @IBOutlet weak var detailCountry: UILabel!
    
    @IBOutlet weak var labelStartYear: UILabel!
    @IBOutlet weak var labelEndYear: UILabel!
    @IBOutlet weak var yearRangeSlider: YSRangeSlider!
    
    @IBOutlet weak var labelRatingMin: UILabel!
    @IBOutlet weak var labelRatingMax: UILabel!
    @IBOutlet weak var ratingRangeSlider: YSRangeSlider!
    
    public var settingsFromSettingsMenu : Settings = Settings.init()
    
    var genre:Genre = Genre.init(genreName: "Нет", genreId: -1) {
        didSet {
            detailGenre.text? = genre.genreName
            
            settingsFromSettingsMenu.selectedGenre = genre
        }
    }
    
    var country:String = "Нет" {
        didSet {
            detailCountry.text? = country
            
            settingsFromSettingsMenu.selectedCountry = country
        }
    }
    
    /// Анвинд с сохраненнием выбранного жанра
    ///
    /// - parameter segue: Сегвей, который делает unwind
    @IBAction func unwindWithSelectedGenre(segue:UIStoryboardSegue) {
        if let genreTableViewController = segue.source as? GenreTableViewController,
            let selectedGenre = genreTableViewController.selectedGenre {
            genre = selectedGenre
        }
    }
    
    
    /// Анвинд с сохраненнием выбранной страны
    ///
    /// - parameter segue: Сегвей, который делает unwind
    @IBAction func unwindWithSelectedCountry(segue:UIStoryboardSegue) {
        if let countrysTableViewController = segue.source as? CountrysTableViewController,
            let selectedCountry = countrysTableViewController.selectedCountry {
            country = selectedCountry
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearRangeSlider.delegate = self
        ratingRangeSlider.delegate = self
        let currentYear : Int = getCurrentYear()
        
        //MARK : Get data from UserDefaults
        settingsFromSettingsMenu.getSettingsFromUserDef()
        
        print("settingsFromSettingsMenu.selectedGenre.genreName \(settingsFromSettingsMenu.selectedGenre.genreName)")
        if(!settingsFromSettingsMenu.selectedGenre.genreName.isEmpty) {
            detailGenre.text = settingsFromSettingsMenu.selectedGenre.genreName
        }
        
        print("settingsFromSettingsMenu.selectedCountry \(settingsFromSettingsMenu.selectedCountry)")
        if (!settingsFromSettingsMenu.selectedCountry.isEmpty) {
            detailCountry.text = settingsFromSettingsMenu.selectedCountry
        }
        
        // MARK: Year slider
        //self.yearRangeSlider.minimumValue = CGFloat(minimalYear)
        //self.yearRangeSlider.maximumValue = CGFloat(currentYear)
        
        print("settingsFromSettingsMenu.minYear \(settingsFromSettingsMenu.minYear)")
        if (settingsFromSettingsMenu.minYear != 0) {
            
            self.yearRangeSlider.minimumSelectedValue = CGFloat(settingsFromSettingsMenu.minYear)
            
        } else {
            
            self.yearRangeSlider.minimumSelectedValue = CGFloat(minimalYear)
        }
        
        print("settingsFromSettingsMenu.maxYear \(settingsFromSettingsMenu.maxYear)")
        if (settingsFromSettingsMenu.maxYear != 0) {
            
            self.yearRangeSlider.maximumSelectedValue = CGFloat(settingsFromSettingsMenu.maxYear)
            
        } else {
            
            self.yearRangeSlider.maximumSelectedValue = CGFloat(currentYear)
        }
        
        self.labelStartYear.text = String(lroundf(Float(self.yearRangeSlider.minimumSelectedValue)))
        self.labelEndYear.text = String(lroundf(Float(self.yearRangeSlider.maximumSelectedValue)))
        
        //MARK: Rating slider
        
        print("settingsFromSettingsMenu.minRating \(settingsFromSettingsMenu.minRating)")
        if(settingsFromSettingsMenu.minRating != 0) {
        
            self.ratingRangeSlider.minimumSelectedValue = CGFloat(settingsFromSettingsMenu.minRating)
            self.labelRatingMin.text = String(round(Float(self.ratingRangeSlider.minimumSelectedValue)))
        } else {
        
            self.labelRatingMin.text = String(round(10*Float(self.ratingRangeSlider.minimumSelectedValue))/10)
        
        }
        
        print("settingsFromSettingsMenu.maxRating \(settingsFromSettingsMenu.maxRating)")
        if(settingsFromSettingsMenu.maxRating != 0) {
            
            self.ratingRangeSlider.maximumSelectedValue = CGFloat(settingsFromSettingsMenu.maxRating)
            self.labelRatingMax.text = String(round(Float(self.ratingRangeSlider.maximumSelectedValue)))
            
        } else {
            
            self.labelRatingMax.text = String(round(10*Float(self.ratingRangeSlider.maximumSelectedValue))/10)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - YSRangeSliderDelegate

extension SettingsMenuController: YSRangeSliderDelegate {
    func rangeSliderDidChange(_ rangeSlider: YSRangeSlider, minimumSelectedValue: CGFloat, maximumSelectedValue: CGFloat) {
        
        //tag = 1 - year
        if(rangeSlider.tag == 1) {
            
            self.labelStartYear.text = String(lroundf(Float(minimumSelectedValue)))
            self.labelEndYear.text = String(lroundf(Float(maximumSelectedValue)))
            
            self.settingsFromSettingsMenu.minYear = Int(self.labelStartYear.text!)!
            self.settingsFromSettingsMenu.maxYear = Int(self.labelEndYear.text!)!
            
        }
        
        //tag = 2 - rating
        if (rangeSlider.tag == 2) {
            
            self.labelRatingMin.text = String(round(10*Float(rangeSlider.minimumSelectedValue))/10)
            self.labelRatingMax.text = String(round(10*Float(rangeSlider.maximumSelectedValue))/10)
            
            self.settingsFromSettingsMenu.minRating = Float(self.labelRatingMin.text!)!
            self.settingsFromSettingsMenu.maxRating = Float(self.labelRatingMax.text!)!
        }
    }
    
}
