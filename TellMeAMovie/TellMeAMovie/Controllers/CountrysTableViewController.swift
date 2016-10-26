//
//  CountrysTableViewController.swift
//  TellMeAMovie
//
//  Created by Илья on 26.10.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit

class CountrysTableViewController: UITableViewController {
    var countrys:[String] = [
        "Нет",
        "Албания",
        "Россия",
        "Испания",
        "США"]
    
    var selectedCountryIndex:Int?
    
    
    /// Получает выбранный жанр
    var selectedCountry:String? {
        didSet {
            if let country = selectedCountry {
                selectedCountryIndex = countrys.index(of: country)!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countrys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countrys[indexPath.row]
        
        if indexPath.row == selectedCountryIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedCountryIndex {
            let cell = tableView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath)
            cell?.accessoryType = .none
        }
        
        selectedCountry = countrys[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedCountry" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedCountry = countrys[index]
                }
            }
        }
    }
}
