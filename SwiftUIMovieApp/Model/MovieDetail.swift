//
//  MovieDetailModel.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 19.09.2024.
//

import Foundation

struct MovieDetail: Codable, Identifiable {
    var id: Int
    var backdrop_path: String
    var budget: Int
    var genres: [Genre]
    var homepage: String
    var imdb_id: String
    var origin_country: [String]
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var production_companies: [ProductionCompany]
    var production_countries: [ProductionCountry]
    var release_date: String
    var revenue: Int
    var runtime: Int
    var spoken_languages: [SpokenLanguages]
    var status: String
    var tagline: String
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Int
}

struct ProductionCompany: Codable, Identifiable {
    var id: Int
    var logo_path: String?
    var name: String
    var origin_country: String
}

struct ProductionCountry: Codable {
    var iso_3166_1: String
    var name: String
}

struct SpokenLanguages: Codable {
    var english_name: String
    var iso_639_1: String
    var name: String
}
