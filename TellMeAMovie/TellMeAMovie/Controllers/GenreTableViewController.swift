//
//  GenreTableViewController.swift
//  TellMeAMovie
//
//  Created by Илья on 26.10.16.
//  Copyright © 2016 IlyaGutnikov. All rights reserved.
//

import UIKit
import TMDBSwift

class GenreTableViewController: UITableViewController {
    
    var genres:[Genre] = []
    
    var selectedGenreIndex:Int?
    
    /// Получает выбранный жанр
    var selectedGenre:Genre?
    
    override func viewDidLoad() {
        
        let decodedGenres = getGenresFromUD()
        
        if (decodedGenres.count == 0) {
            
            GenresMDB.genres(TMDb_APIv3_key, listType: .movie, language: language) {
                
                apiReturn, TMDBgenres in
                if let TMDBgenres = TMDBgenres{
                    
                    self.genres.removeAll()
                    self.genres.append(Genre.init(genreName: "Нет", genreId: -1))
                    
                    TMDBgenres.forEach{
                        
                        self.genres.append( Genre.init(genreName: $0.name!, genreId: $0.id!))
                    }
                    
                    self.tableView.reloadData()
                    saveGenresToUD(genres: self.genres)
                }
                
            }
            
        } else {
            
            self.genres = decodedGenres
            self.tableView.reloadData()
            
        }
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
        return genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row].genreName
        
        if indexPath.row == selectedGenreIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedGenreIndex {
            let cell = tableView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath)
            cell?.accessoryType = .none
        }
        
        selectedGenre = genres[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedGenre" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedGenre = genres[index]
                }
            }
        }
    }
    
}
