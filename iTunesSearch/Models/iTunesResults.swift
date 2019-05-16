//
//  iTunesResults.swift
//  iTunesSearch
//
//  Created by Dustin Koch on 5/16/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

struct TopLevelJSON: Decodable {
    let results: [iTunesResults]
}

struct iTunesResults: Decodable {
    
    let artist: String
    let track: String
    let album: String?
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case track = "trackName"
        case album = "collectionName"
        case imageURL = "artworkUrl30"
    }
}
