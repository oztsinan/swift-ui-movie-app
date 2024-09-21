//
//  MovieDetailView.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 19.09.2024.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    var movieId: Int

    @StateObject var movieService = MovieService()
    @StateObject var genreService = GenreService()
    @State var showDescriptionSheetPresented = false

    private func getYear(from dateString: String?) -> String {
        // Optional string boşsa, direkt boş string döndür
        guard let dateString = dateString else {
            return ""
        }

        // Tarihi parse etmek için formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Gelen tarih formatı

        // Sadece yılı döndürecek ikinci formatter
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        // Tarih parse edilebilirse yıl döndür, yoksa boş string döndür
        if let date = dateFormatter.date(from: dateString) {
            return yearFormatter.string(from: date)
        } else {
            return ""
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    if let movieDetail = movieService.movieDetail {
                        VStack {
                            ZStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(movieDetail.backdrop_path)")) {
                                    image in
                                    image.image?.resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width, height: 500)
                                        .clipped()
                                }
                                LinearGradient(gradient: Gradient(colors: [.clear, Color(.systemBackground)]), startPoint: .top, endPoint: .bottom)

                                VStack {
                                    Spacer()
                                    Text(movieDetail.title)
                                        .font(.title2)
                                        .bold()

                                    Button {
                                        showDescriptionSheetPresented = true
                                    } label: {
                                        Text(movieDetail.overview)
                                            .multilineTextAlignment(.leading)
                                            .font(.subheadline)
                                            .foregroundStyle(.gray)
                                            .lineLimit(3)
                                    }
                                    .sheet(isPresented: $showDescriptionSheetPresented, content: {
                                        NavigationStack {
                                            ScrollView {
                                                Text(movieDetail.overview)
                                                    .padding()
                                            }
                                            .navigationTitle("Description")
                                            .navigationBarTitleDisplayMode(.inline)
                                        }
                                    })
                                }
                                .frame(width: .infinity)
                                .padding()
                            }
                            .frame(height: 500)
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 500)
                        .padding(.bottom, 10)
                        .background(Color(.systemBackground))
                    }

                    VStack {
                        if let movieVideos = movieService.movieVideos?.results, !movieVideos.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Videos")
                                    .font(.title2)
                                    .bold()
                                    .padding(.leading)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top) {
                                        ForEach(movieVideos, id: \.id) { video in
                                            YoutubeItem(key: video.key, title: video.name, caption: video.type)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }

                        if let movieRecommendations = movieService.movieRecommendations?.results {
                            VStack(alignment: .leading) {
                                Text("Recommendations")
                                    .font(.title2)
                                    .bold()
                                    .padding(.leading)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top) {
                                        ForEach(movieRecommendations, id: \.id) { movie in
                                            MovieItem(id: movie.id, backdrop_path: movie.backdrop_path, title: movie.title, overview: movie.title)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }

                        if let movieCreditsCast = movieService.movieCredits?.cast {
                            VStack(alignment: .leading) {
                                Text("Cast")
                                    .font(.title2)
                                    .bold()
                                    .padding(.leading)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top) {
                                        ForEach(movieCreditsCast, id: \.id) { castMember in
                                            PersonItem(personId: castMember.id, profile_path: castMember.profile_path, title: castMember.name, subtitle: castMember.character)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }

                        if let movieCreditsCrew = movieService.movieCredits?.crew {
                            VStack(alignment: .leading) {
                                Text("Crew")
                                    .font(.title2)
                                    .bold()
                                    .padding(.leading)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top) {
                                        ForEach(movieCreditsCrew, id: \.id) { crewMember in
                                            PersonItem(personId: crewMember.id, profile_path: crewMember.profile_path, title: crewMember.name, subtitle: crewMember.department)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .background(Color(.systemBackground))

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Information")
                            .font(.title2)
                            .bold()

                        if let genres = movieService.movieDetail?.genres,!genres.isEmpty {
                            let genreNames = genres.map { $0.name }.joined(separator: ",")
                            VStack(alignment: .leading) {
                                Text("Genres")
                                    .font(.caption)
                                Text(genreNames)
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                            }
                        }

                        if let productionCompaines = movieService.movieDetail?.production_companies,!productionCompaines.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Studio")
                                    .font(.caption)

                                let companyNames = productionCompaines.map {
                                    $0.name
                                }.joined(separator: ",")

                                Text(companyNames)
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                            }
                        }

                        if let productionCountries = movieService.movieDetail?.production_countries {
                            let productionCountryNames = productionCountries.map {
                                $0.name
                            }.joined(separator: ",")

                            VStack(alignment: .leading) {
                                Text("Countries")
                                    .font(.caption)
                                Text(productionCountryNames)
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                            }
                        }

                        if let releaseDateString = movieService.movieDetail?.release_date {
                            VStack(alignment: .leading) {
                                Text("Released")
                                    .font(.caption)
                                Text(getYear(from: releaseDateString))
                                    .font(.caption)
                                    .foregroundStyle(Color(.systemGray))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .background(Color(.secondarySystemBackground))
            .onAppear {
                Task {
                    await movieService.fetchGetById(id: movieId)
                    await movieService.fetchGetCreditsById(id: movieId)
                    await movieService.fetchRecommendationsById(id: movieId)
                    await movieService.fetchVideosById(id: movieId)
                    await genreService.fetchAllMovieGenres()
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

#Preview {
    MovieDetailView(movieId: 533535)
}
