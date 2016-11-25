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
    
    var genre:Genre = Genre.init(genreName: "No", genreId: -1) {
        didSet {
            detailGenre.text? = genre.genreName
        }
    }
    
    var country:String = "Нет" {
        didSet {
            detailCountry.text? = country
        }
    }
    
    /// Анвинд с сохраненнием выбранного жанра
    ///
    /// - parameter segue: Сегвей, который делает unwind
    @IBAction func unwindWithSelectedGenre(segue:UIStoryboardSegue) {
        if let genreTableViewController = segue.source as? GenreTableViewController,
            let selectedGenre = genreTableViewController.selectedGenre {
            genre = selectedGenre
            
            print("unwindWithSelectedGenre")
            print(genre.genreName)
            print(genre.genreId)
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
