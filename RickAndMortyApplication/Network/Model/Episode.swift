//
//  Episode.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 4.02.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let lastEpisode = try? newJSONDecoder().decode(LastEpisode.self, from: jsonData)

import Foundation

// MARK: - LastEpisode
struct LastEpisode: Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
            case id, name
            case airDate = "air_date"
            case episode, characters, url, created
        }
}

