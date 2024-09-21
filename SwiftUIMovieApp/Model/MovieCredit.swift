//
//  MovieCredit.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 20.09.2024.
//

import Foundation

struct MovieCredit: Codable {
    var id: Int
    var cast: [MovieCreditCast]
    var crew: [MovieCreditCrew]
}

struct MovieCreditCast: Codable, Identifiable {
    var adult: Bool
    var gender: Int
    var id: Int
    var known_for_department: String
    var name: String
    var original_name: String
    var popularity: Float?
    var profile_path: String?
    var cast_id: Int
    var character: String
    var credit_id: String
    var order: Int
}

struct MovieCreditCrew: Codable, Identifiable {
    var adult: Bool
    var gender: Int
    var id: Int
    var known_for_department: String
    var name: String
    var original_name: String
    var popularity: Float?
    var profile_path: String?
    var credit_id: String
    var department: String
    var job: String
}
