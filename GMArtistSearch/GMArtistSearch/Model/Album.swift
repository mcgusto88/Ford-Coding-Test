//
//  Album.swift
//  GMArtistSearch
//
//  Created by Augustus Wilson on 2/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import Foundation

struct AlbumFeed: Decodable {
    let results: [Album]
}

struct Album : Codable {
    let name : String?
    let artistName: String
    let imageUrl : String
    let releaseDate : String
    let primaryGenreName: String
    let trackPrice : Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artistName
        case imageUrl = "artworkUrl100"
        case releaseDate
        case primaryGenreName
        case trackPrice
    }
    
}

