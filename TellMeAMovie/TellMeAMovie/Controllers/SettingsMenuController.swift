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
    
    
    /// Анвинд с сохраненнием выбранного жанра
    ///
    /// - parameter segue: Сегвей, который делает unwind
    @IBAction func unwindWithSelectedGenre(segue:UIStoryboardSegue) {
        if let genreTableViewController = segue.source as? GenreTableViewController,
            let selectedGenre = genreTableViewController.selectedGenre {
            genre = selectedGenre
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
        
        // MARK: Year slider
        self.yearRangeSlider.minimumValue = CGFloat(minimalYear)
        self.yearRangeSlider.maximumValue = CGFloat(currentYear)
        
        print("settingsFromSettingsMenu.minYear \(settingsFromSettingsMenu.minYear)")
        self.yearRangeSlider.minimumSelectedValue = CGFloat(settingsFromSettingsMenu.minYear)
        
        print("settingsFromSettingsMenu.maxYear \(settingsFromSettingsMenu.maxYear)")
        self.yearRangeSlider.maximumSelectedValue = CGFloat(settingsFromSettingsMenu.maxYear)
        
        //MARK: Rating slider
        
        print("settingsFromSettingsMenu.minRating \(settingsFromSettingsMenu.minRating)")
        self.ratingRangeSlider.minimumSelectedValue = CGFloat(settingsFromSettingsMenu.minRating)
        
        print("settingsFromSettingsMenu.maxRating \(settingsFromSettingsMenu.maxRating)")
        self.ratingRangeSlider.maximumSelectedValue = CGFloat(settingsFromSettingsMenu.maxRating)
        
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
        }
        
        //tag = 2 - rating
        if (rangeSlider.tag == 2) {
            
            self.labelRatingMin.text = String(round(10*Float(rangeSlider.minimumSelectedValue))/10)
            self.labelRatingMax.text = String(round(10*Float(rangeSlider.maximumSelectedValue))/10)
        }
    }
    
}
