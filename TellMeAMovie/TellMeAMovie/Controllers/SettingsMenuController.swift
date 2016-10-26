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
    
    @IBAction func unwindWithSelectedGenre(segue:UIStoryboardSegue) {
        if let genreTableViewController = segue.source as? GenreTableViewController,
            let selectedGenre = genreTableViewController.selectedGenre {
            genre = selectedGenre
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
