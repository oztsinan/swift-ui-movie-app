//
//  PersonItem.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 20.09.2024.
//

import SwiftUI

struct PersonItem: View {
    var personId: Int
    var profile_path: String?
    var title: String
    var subtitle: String

    var body: some View {
        NavigationLink {
            PersonView(personId: personId, personName: title)

        } label: {
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(profile_path ?? "")")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()

                    } else if phase.error != nil {
                        Color(.opaqueSeparator)

                    } else {
                        Color(.opaqueSeparator)
                    }
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())

                Text(title)
                    .foregroundStyle(Color(.label))
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray))
                    .multilineTextAlignment(.center)
            }
            .frame(width: 100)
        }
    }
}
