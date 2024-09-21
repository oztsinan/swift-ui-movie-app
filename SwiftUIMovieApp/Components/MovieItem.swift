//
//  MovieItem.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 20.09.2024.
//

import SwiftUI

struct MovieItem: View {
    var id: Int
    var backdrop_path: String?
    var title: String
    var overview: String

    var body: some View {
        NavigationLink {
            MovieDetailView(movieId: id)
        } label: {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(backdrop_path ?? "")")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else if phase.error != nil {
                        Color(.opaqueSeparator)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Color(.opaqueSeparator)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .frame(width: 150, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(title)
                    .font(.caption)
                    .foregroundStyle(Color(.label))
                    .lineLimit(1)

                Text(overview)
                    .font(.caption2)
                    .foregroundStyle(Color(.systemGray))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: 150)
        }
    }
}
