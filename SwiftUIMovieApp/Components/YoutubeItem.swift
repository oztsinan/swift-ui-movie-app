
//
//  YoutubeItem.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 20.09.2024.
//

import SwiftUI

struct YoutubeItem: View {
    @State private var showSafari = false

    var key: String
    var title: String
    var caption: String

    var body: some View {
        Button {
            showSafari = true
        }
        label: {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: "https://img.youtube.com/vi/\(key)/sddefault.jpg")) { phase in
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
                .overlay {
                    Color.black.opacity(0.5)
                    Image(systemName: "play.fill")
                        .foregroundStyle(.white)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(title)
                    .font(.caption)
                    .foregroundStyle(Color(.label))
                    .lineLimit(1)

                Text(caption)
                    .font(.caption2)
                    .foregroundStyle(Color(.systemGray))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: 150)
        }
        .fullScreenCover(isPresented: $showSafari) {
            if let url = URL(string: "https://www.youtube.com/watch?v=" + key) {
                SafariView(url: url)
                    .ignoresSafeArea()
            }
        }
    }
}
