//
//  PaginationResponse.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 21.09.2024.
//

import Foundation

struct PaginationResponse<T: Codable>: Codable {
    var page: Int
    var total_pages: Int
    var total_results: Int
    var results: [T]
}
