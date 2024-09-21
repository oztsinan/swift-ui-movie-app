//
//  HomeView.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 15.09.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var movieService = MovieService()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    TabView {
                        ForEach(movieService.popular, id: \.id) {
                            movie in HomeViewTopSliderItem(id: movie.id, title: movie.title, description: movie.overview, image: movie.backdrop_path)
                        }
                    }
                    .frame(height: 500)
                    .tabViewStyle(
                        PageTabViewStyle(indexDisplayMode: .always))

                    HomeViewCategorySlider(
                        data: movieService.nowPlaying,
                        title: "New Movies",
                        caption: "Catch the latest hits in cinema, don't miss out!"
                    )
                    HomeViewCategorySlider(
                        data: movieService.topRated,
                        title: "Highest Scorers",
                        caption: "Watch the top-rated films everyone is talking about!"
                    )
                    HomeViewCategorySlider(
                        data: movieService.upcoming,
                        title: "Upcoming Movies",
                        caption: "Stay ahead of the game, be the first to know about upcoming films!"
                    )
                }
            }
            .navigationTitle("Home")
            .edgesIgnoringSafeArea(.top)
            .safeAreaPadding(.bottom)
            .onAppear {
                Task {
                    await movieService.fetchPopular()
                    await movieService.fetchUpcoming()
                    await movieService.fetchTopRated()
                    await movieService.fetchNowPlaying()
                }
            }
        }
    }
}

struct HomeViewTopSliderItem: View {
    var id: Int
    var title: String
    var description: String
    var image: String?

    var body: some View {
        NavigationLink {
            MovieDetailView(movieId: id)
        } label: {
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + (image ?? ""))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.width, height: 500)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 500)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width, height: 500)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .overlay {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.clear, Color(.systemBackground)]), startPoint: .top, endPoint: .bottom)

                    VStack(spacing: 5) {
                        Spacer()
                        Text(title)
                            .foregroundStyle(Color(.label))
                            .font(.title2)
                            .bold()
                            .frame(width: UIScreen.main.bounds.width - 40)

                        Text(description)
                            .foregroundStyle(Color(.systemGray))
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .lineLimit(2)
                        Spacer().frame(height: 50)
                    }
                }
            }
        }
    }
}

struct HomeViewCategorySlider: View {
    var data: [Movie]
    var title: String
    var caption: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
                .padding(.horizontal)
            Text(caption)
                .font(.caption)
                .foregroundStyle(Color(.systemGray))
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(data, id: \.id) {
                        movie in

                        MovieItem(id: movie.id, backdrop_path: movie.backdrop_path, title: movie.title, overview: movie.overview)
                    }
                }
            }
            .safeAreaPadding(.horizontal)
        }
    }
}

#Preview {
    TabNavigationView()
}
