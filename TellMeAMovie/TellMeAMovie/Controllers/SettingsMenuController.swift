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
        
    }
    
    @IBOutlet weak var endYearSlider: UISlider!
    
    @IBAction func endYearSliderAction(_ sender: AnyObject) {
        
        self.endYearTextBox.text = String(lroundf(self.endYearSlider.value))
        
    }
    
    @IBOutlet weak var endYearTextBox: UILabel!
    
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
