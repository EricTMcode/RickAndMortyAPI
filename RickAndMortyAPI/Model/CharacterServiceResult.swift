//
//  CharacterServiceResult.swift
//  RickAndMortyAPI
//
//  Created by Eric on 05/06/2023.
//

import Foundation

struct CharacterServiceResult: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
}
