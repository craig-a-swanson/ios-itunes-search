//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Craig Swanson on 10/31/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
