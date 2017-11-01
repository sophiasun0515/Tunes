//
//  SongDownloader.swift
//  Tunes
//
//  Created by Apple on 10/31/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

struct SongDownloader {
    
    struct SongResponse : Codable {
        let results: [Song]
        let resultCount: Int
    }
    
    static func downloadSongs(searchTerm: String, completion: @escaping ([Song]) -> Void) {
        let searchTermWithoutSpaces = searchTerm.replacingOccurrences(of: " ", with: "%20")
        let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchTerm
        let url = URL(string: "https://itunes.apple.com/search?term=\(encodedTerm)&entity=song")!
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "Error making request")
                completion([])
                return
            }
//            guard let jsonObject = try? JSONSerialization.jsonObject(with: data),
//                let typedJson = jsonObject as? [String: Any],
//                let results = typedJson["results"] as? [[String: Any]] else
//                {
//                print("Failed json parsing")
//                completion([])
//                return
//            }
            
            let jsonDecoder = JSONDecoder()
//            var songs: [Song] = []
            if let songResponse = try? jsonDecoder.decode(SongResponse.self, from: data) {
                completion(songResponse.results)
            }
//            for songJson in results {
//                if let trackName = songJson["trackName"] as? String,
//                    let artistName = songJson["artistName"] as? String,
//                    let trackTimeMillis = songJson["trackTimeMillis"] as? Int,
//                    let trackPrice = songJson["trackPrice"] as? Double {
//                    let song = Song(trackName: trackName, artistName: artistName, trackTimeMillis: trackTimeMillis, trackPrice: trackPrice)
//                    songs.append(song)
//                } else {
//                    print("Failed to parse song: \(songJson)")
//                }
//
//            }
            
            
     
        }
        task.resume()
        
    }
}
