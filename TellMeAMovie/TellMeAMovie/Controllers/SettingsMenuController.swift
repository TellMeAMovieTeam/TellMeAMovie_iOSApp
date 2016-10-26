//
//  SettingsMenuController.swift
//  TellMeAMovie
//
//  Created by Илья on 26.10.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit

class SettingsMenuController: UITableViewController {
    
    @IBOutlet weak var detailGenre: UILabel!

    @IBOutlet weak var detailCountry: UILabel!
    
    var genre:String = "Нет" {
        didSet {
            detailGenre.text? = genre
        }
    }
    
    var country:String = "Нет" {
        didSet {
            detailCountry.text? = country
        }
    }
    
    @IBOutlet weak var startYearSlider: UISlider!
    
    @IBOutlet weak var startYearTextBox: UILabel!
    
    @IBAction func startYearSliderAction(_ sender: AnyObject) {
        
        self.startYearTextBox.text = String(lroundf(self.startYearSlider.value))
        self.startYearSlider.maximumValue = self.endYearSlider.value
        
    }
    
    
    @IBOutlet weak var endYearSlider: UISlider!
    
    @IBAction func endYearSliderAction(_ sender: AnyObject) {
        
        self.endYearTextBox.text = String(lroundf(self.endYearSlider.value))
        self.endYearSlider.minimumValue = self.startYearSlider.value
    }
    
    @IBOutlet weak var endYearTextBox: UILabel!
    
    
    @IBOutlet weak var startRatingSlider: UISlider!
    @IBAction func startRatingSliderAction(_ sender: AnyObject) {
        
        self.startRatingTextBox.text = String(roundf(100*startRatingSlider.value)/100)
        self.startRatingSlider.maximumValue = self.endRatingSlider.value
    }
    
    @IBOutlet weak var startRatingTextBox: UILabel!
    
    
    @IBOutlet weak var endRatingSlider: UISlider!
    
    @IBAction func endRatingSliderAction(_ sender: AnyObject) {
        
        self.endRatingTextBox.text = String(roundf(100*endRatingSlider.value)/100)
        self.endRatingSlider.minimumValue = self.startRatingSlider.value
        
        
    }
    @IBOutlet weak var endRatingTextBox: UILabel!
    
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
        
        self.startYearSlider.minimumValue = 1950
        self.startYearSlider.maximumValue = 2016
        self.startYearSlider.value = self.startYearSlider.minimumValue
        self.startYearTextBox.text = String(lroundf(startYearSlider.minimumValue))
        
        self.endYearSlider.minimumValue = 1950
        self.endYearSlider.maximumValue = 2016
        self.endYearTextBox.text = String(lroundf(endYearSlider.maximumValue))
        self.endYearSlider.value = self.endYearSlider.maximumValue
        
        self.startRatingSlider.minimumValue = 0
        self.startRatingSlider.maximumValue = 10
        self.startRatingSlider.value = self.startRatingSlider.minimumValue
        self.startRatingTextBox.text = String(lroundf(startRatingSlider.minimumValue))
        
        self.endRatingSlider.minimumValue = 0
        self.endRatingSlider.maximumValue = 10
        self.endRatingSlider.value = self.endRatingSlider.maximumValue
        self.endRatingTextBox.text = String(lroundf(endRatingSlider.maximumValue))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
