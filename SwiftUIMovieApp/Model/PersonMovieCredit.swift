//
//  PersonMovieCredits.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 20.09.2024.
//

import Foundation

struct PersonMovieCredit: Codable {
    var id: Int
    var cast: [PersonMovieCreditCast]?
    var crew: [PersonMovieCreditCrew]?
}

struct PersonMovieCreditCast: Codable, Identifiable {
    var adult: Bool
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float?
    var poster_path: String?
    var release_date: String?
    var title: String
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
    var character: String
    var credit_id: String
    var order: Int?
}

struct PersonMovieCreditCrew: Codable, Identifiable {
    var adult: Bool
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float?
    var poster_path: String?
    var release_date: String?
    var title: String
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
    var credit_id: String
    var department: String
    var job: String
}
