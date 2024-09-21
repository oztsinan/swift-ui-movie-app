//
//  GenreModel.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 18.09.2024.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Identifiable {
    var id: Int
    var name: String
}
