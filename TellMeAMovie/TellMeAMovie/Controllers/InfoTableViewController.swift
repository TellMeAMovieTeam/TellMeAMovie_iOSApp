//
//  InfoTableViewController.swift
//  TellMeAMovie
//
//  Created by Илья on 02.12.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func writeLetter(_ sender: UIButton) {
        
        
    }


}
