//
//  PersonView.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 20.09.2024.
//

import SwiftUI

struct PersonView: View {
    var personId: Int
    var personName: String
    @StateObject var movieService = MovieService()

    var body: some View {
        NavigationStack {
            ScrollView {
                if let personMovieCreditsCast = movieService.personMovieCredits?.cast,!personMovieCreditsCast.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Cast")
                            .font(.title2)
                            .bold()
                            .padding(.leading)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top) {
                                ForEach(personMovieCreditsCast, id: \.id) { movie in
                                    MovieItem(id: movie.id, backdrop_path: movie.backdrop_path, title: movie.title, overview: movie.character)
                                }
                            }
                        }
                        .safeAreaPadding(.horizontal)
                    }
                }

                if let personMovieCreditsCrew = movieService.personMovieCredits?.crew,!personMovieCreditsCrew.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Crew")
                            .font(.title2)
                            .bold()
                            .padding(.leading)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top) {
                                ForEach(personMovieCreditsCrew, id: \.id) { movie in
                                    MovieItem(id: movie.id, backdrop_path: movie.backdrop_path, title: movie.title, overview: movie.job)
                                }
                            }
                        }
                        .safeAreaPadding(.horizontal)
                    }
                }
            }

            .navigationTitle(personName)
        }
        .onAppear {
            Task {
                await movieService.fetchGetCreditsByPersonId(personId: personId)
            }
        }
    }
}

#Preview {
    PersonView(personId: 74376, personName: "Cem Yılmaz")
}
