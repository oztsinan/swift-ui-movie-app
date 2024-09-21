//
//  GenreService.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 18.09.2024.
//

import Foundation

class GenreService: ObservableObject {
    @Published var movieGenres: [Genre] = []
    @Published var tvGenres: [Genre] = []

    private let networkService = NetworkService()

    func fetchAllMovieGenres() async {
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list")!

        do {
            let response: GenreResponse = try await networkService.performRequest(url: url, method: .GET, expecting: GenreResponse.self)
            DispatchQueue.main.async {
                self.movieGenres = response.genres
            }
        } catch {
            print("Failed to fetch movie genres: \(error.localizedDescription)")
        }
    }

    func fetchAllTVGenres() async {
        let url = URL(string: "https://api.themoviedb.org/3/genre/tv/list")!

        do {
            let response: GenreResponse = try await networkService.performRequest(url: url, method: .GET, expecting: GenreResponse.self)
            DispatchQueue.main.async {
                self.tvGenres = response.genres
            }
        } catch {
            print("Failed to fetch TV genres: \(error.localizedDescription)")
        }
    }
}
