//
//  CharacterDetail.swift
//  RickAndMortyApplication
//
//  Created by Yasemin TOK on 30.01.2022.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let characterDetail = try? newJSONDecoder().decode(CharacterDetail.self, from: jsonData)

import Foundation

// MARK: - CharacterDetail
struct CharacterDetail: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}


