//
//  Artists.swift
//  FindThatArtist
//
//  Created by Field Employee on 2/20/21.
//

import Foundation

struct Artist: Decodable{
    let results: [ArtistDetails]
    
    enum CodingKeys: String, CodingKey{
        case results
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
                self.results = try container.decodeIfPresent([ArtistDetails].self, forKey: .results)!
    }
}

struct ArtistDetails: Decodable{
    let artistName: String
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let trackPrice: Double
    
    enum CodingKeys: String, CodingKey{
        case artistName
        case trackName
        case releaseDate
        case primaryGenreName
        case trackPrice
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
        self.trackPrice = try container.decode(Double.self, forKey: .trackPrice)
    }
}
