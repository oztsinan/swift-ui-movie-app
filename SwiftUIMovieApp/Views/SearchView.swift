//
//  SearchView.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 16.09.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var currentPage: Int = 1
    @State private var isLoading = false

    @StateObject var movieService = MovieService()

    var body: some View {
        NavigationStack {
            List {
                if let results = movieService.searchMovie?.results,!results.isEmpty {
                    ForEach(results, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(movieId: movie.id)
                        } label: {
                            Text(movie.title)
                        }
                        .onAppear {
                            if movie == results.last {
                                Task {
                                    currentPage += 1
                                    await movieService.fetchSearchMovie(query: searchText, page: currentPage)
                                }
                            }
                        }
                    }
                }

                if isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                            .padding()
                        Spacer()
                    }
                } else if searchText.isEmpty {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                            .padding()
                        Text("Do a search")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let results = movieService.searchMovie?.results, results.isEmpty {
                    VStack {
                        Image(systemName: "exclamationmark.magnifyingglass")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                            .padding()
                        Text("Not Found")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }

            .onAppear {
                Task {
                    isLoading = true
                    await movieService.fetchSearchMovie(query: searchText, page: currentPage)
                    isLoading = false
                }
            }
            .onChange(of: searchText) {
                Task {
                    isLoading = true
                    currentPage = 1
                    await movieService.fetchSearchMovie(query: searchText, page: currentPage)
                    isLoading = false
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    SearchView()
}
