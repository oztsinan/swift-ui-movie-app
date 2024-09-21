//
//  GenericResponse.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 21.09.2024.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var id: Int
    var results: [T]
}
