//
//  MovieModel.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 18.09.2024.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable {
    var id: Int
    var adult: Bool
    var title: String
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var backdrop_path: String?
    var poster_path: String?
    var release_date: String?
    var video: Bool
    var vote_average: Float
    var vote_count: Int
    var genre_ids: [Int]?
}
