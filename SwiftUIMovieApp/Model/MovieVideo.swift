//
//  MovieVideo.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 21.09.2024.
//

import Foundation

struct MovieVideo: Codable, Identifiable {
    var iso_639_1: String
    var iso_3166_1: String
    var name: String
    var key: String
    var site: String
    var size: Int
    var type: String
    var official: Bool
    var published_at: String
    var id: String
}
