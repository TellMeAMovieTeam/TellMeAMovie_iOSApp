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
        
        //TODO вставить обработку получения сохраненых данных
        
        // MARK: Year slider
        let currentYear : Int = getCurrentYear()
        
        self.yearRangeSlider.minimumValue = CGFloat(minimalYear)
        self.yearRangeSlider.minimumSelectedValue = CGFloat(minimalYear)
        
        self.yearRangeSlider.maximumValue = CGFloat(currentYear)
        self.yearRangeSlider.maximumSelectedValue = CGFloat(currentYear)
        
        self.labelStartYear.text = String(lroundf(Float(self.yearRangeSlider.minimumSelectedValue)))
        self.labelEndYear.text = String(lroundf(Float(self.yearRangeSlider.maximumSelectedValue)))
        
        //MARK: Rating slider
        
        self.labelRatingMin.text = String(round(10*Float(self.ratingRangeSlider.minimumSelectedValue))/10)
        self.labelRatingMax.text = String(round(10*Float(self.ratingRangeSlider.maximumSelectedValue))/10)
        
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
            
            self.labelStartYear.text = String(lroundf(Float(self.yearRangeSlider.minimumSelectedValue)))
            self.labelEndYear.text = String(lroundf(Float(self.yearRangeSlider.maximumSelectedValue)))
            
        }
        
        //tag = 2 - rating
        if (rangeSlider.tag == 2) {
        
            self.labelRatingMin.text = String(round(10*Float(self.ratingRangeSlider.minimumSelectedValue))/10)
            self.labelRatingMax.text = String(round(10*Float(self.ratingRangeSlider.maximumSelectedValue))/10)
        
        }
    }
    
}
