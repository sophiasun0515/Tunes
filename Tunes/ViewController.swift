//
//  ViewController.swift
//  Tunes
//
//  Created by Apple on 10/31/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var songs: [Song] = [
        Song(trackName: "Run the World (Girls)", artistName: "Beyoncé", trackTimeMillis: 238305, trackPrice: 1.29)
    ]
    
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        SongDownloader.downloadSongs(searchTerm: "Beyonce") {(songs) in
//            DispatchQueue.main.async {
//                self.songs = songs
//                self.tableView.reloadData()
//            }
//        }
        searchBar.sizeToFit()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CELL_ID = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CELL_ID)
        
        let song = songs[indexPath.row]
        cell.textLabel?.text = "\(song.trackName) by \(song.artistName)"
        cell.detailTextLabel?.text = "\(song.displayTrackTime) for just $\(song.trackPrice)"
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SongDownloader.downloadSongs(searchTerm: searchBar.text!) { (songs) in DispatchQueue.main.async {
                self.songs = songs
                self.tableView.reloadData()
            }
        }
    }
}


