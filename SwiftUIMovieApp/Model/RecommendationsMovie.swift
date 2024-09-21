//
//  RecommendationsMovie.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 21.09.2024.
//

import Foundation

struct RecommendationsMovie: Codable, Identifiable {
    var backdrop_path: String?
    var id: Int
    var title: String
    var original_title: String
    var overview: String
    var poster_path: String?
    var media_type: String
    var adult: Bool
    var original_language: String
    var genre_ids: [Int]?
    var popularity: Float?
    var release_date: String
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
}
