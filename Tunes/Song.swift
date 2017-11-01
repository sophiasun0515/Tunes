//
//  Song.swift
//  Tunes
//
//  Created by Apple on 10/31/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

struct Song: Codable {
    let trackName: String
    let artistName: String
    let trackTimeMillis: Int
    let trackPrice: Double
    
    var displayTrackTime: String {
        let seconds = trackTimeMillis / 60
        let minutes = seconds % 60
        return "\(minutes):\(seconds % 60)"
    }
}
