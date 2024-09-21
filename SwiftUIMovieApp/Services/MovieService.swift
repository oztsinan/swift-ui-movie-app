//
//  MovieService.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 18.09.2024.
//

import Foundation

class MovieService: ObservableObject {
    @Published var movieDetail: MovieDetail? = nil
    @Published var popular: [Movie] = []
    @Published var nowPlaying: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var upcoming: [Movie] = []
    @Published var movieCredits: MovieCredit? = nil
    @Published var personMovieCredits: PersonMovieCredit? = nil
    @Published var searchMovie: PaginationResponse<Movie>? = nil
    @Published var movieRecommendations: PaginationResponse<RecommendationsMovie>? = nil
    @Published var movieVideos: GenericResponse<MovieVideo>? = nil

    private let networkService = NetworkService()
    
    func fetchPopular() async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
         
        do {
            let response: PaginationResponse<Movie> = try await networkService.performRequest(url: url, method: .GET, expecting: PaginationResponse<Movie>.self)
            DispatchQueue.main.async {
                self.popular = response.results
            }
        } catch {
            print("Failed to fetch popular movies: \(error)")
        }
    }
    
    func fetchNowPlaying() async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
        
        do {
            let response: PaginationResponse<Movie> = try await networkService.performRequest(url: url, method: .GET, expecting: PaginationResponse<Movie>.self)
            DispatchQueue.main.async {
                self.nowPlaying = response.results
            }
        } catch {
            print("Failed to fetch now playing movies: \(error)")
        }
    }
    
    func fetchTopRated() async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated")!
           
        do {
            let response: PaginationResponse<Movie> = try await networkService.performRequest(url: url, method: .GET, expecting: PaginationResponse<Movie>.self)
            DispatchQueue.main.async {
                self.topRated = response.results
            }
        } catch {
            print("Failed to fetch top rated movies: \(error)")
        }
    }
    
    func fetchUpcoming() async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
        
        do {
            let response: PaginationResponse<Movie> = try await networkService.performRequest(url: url, method: .GET, expecting: PaginationResponse<Movie>.self)
            DispatchQueue.main.async {
                self.upcoming = response.results
            }
        } catch {
            print("Failed to fetch upcoming movies: \(error)")
        }
    }
    
    func fetchGetById(id: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)")!
        
        do {
            let response: MovieDetail = try await networkService.performRequest(url: url, method: .GET, expecting: MovieDetail.self)
            DispatchQueue.main.async {
                self.movieDetail = response
            }
        } catch {
            print("Failed to fetch movie details: \(error)")
        }
    }
    
    func fetchGetCreditsById(id: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits")!
          
        do {
            let response: MovieCredit = try await networkService.performRequest(url: url, method: .GET, expecting: MovieCredit.self)
            DispatchQueue.main.async {
                self.movieCredits = response
            }
        } catch {
            print("Failed to fetch movie credits: \(error)")
        }
    }
    
    func fetchGetCreditsByPersonId(personId: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/person/\(personId)/movie_credits")!
          
        do {
            let response: PersonMovieCredit = try await networkService.performRequest(url: url, method: .GET, expecting: PersonMovieCredit.self)
            DispatchQueue.main.async {
                self.personMovieCredits = response
            }
        } catch {
            print("Failed to fetch person movie credits: \(error)")
        }
    }
      
    func fetchSearchMovie(query: String, page: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/search/movie")!
        
        let queryParameters: [String: String] = [
            "query": query,
            "page": String(page)
        ]
        
        do {
            let response: PaginationResponse<Movie> = try await networkService.performRequest(url: url, method: .GET, query: queryParameters, expecting: PaginationResponse<Movie>.self)
            
            DispatchQueue.main.async {
                if page == 1 {
                    // İlk sayfa ise, mevcut sonuçları sıfırla
                    self.searchMovie = response
                } else {
                    // Yeni sonuçları mevcut sonuçlarla birleştir
                    self.searchMovie?.results.append(contentsOf: response.results)
                }
            }
        } catch {
            DispatchQueue.main.async {
                print("Failed to fetch: \(error)")
            }
        }
    }

    func fetchRecommendationsById(id: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/recommendations")!
         
        do {
            let response: PaginationResponse<RecommendationsMovie> = try await networkService.performRequest(url: url, method: .GET, expecting: PaginationResponse<RecommendationsMovie>.self)
            DispatchQueue.main.async {
                self.movieRecommendations = response
            }
        } catch {
            print("Failed to fetch movie recommendations: \(error)")
        }
    }
    
    func fetchVideosById(id: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos")!
          
        do {
            let response: GenericResponse<MovieVideo> = try await networkService.performRequest(url: url, method: .GET, expecting: GenericResponse<MovieVideo>.self)
            DispatchQueue.main.async {
                self.movieVideos = response
            }
        } catch {
            print("Failed to fetch movie videos: \(error)")
        }
    }
}
