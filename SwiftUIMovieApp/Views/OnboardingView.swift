//
//  OnboardingView.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 14.09.2024.
//

import SwiftUI

struct OnboardingData {
    var id = UUID()
    var title: String
    var description: String
    var icon: String
    var iconColor: Color
}

struct OnboardingView: View {
    @State var sectionIndex: Int = 0

    let onboardingItems = [
        OnboardingData(
            title: "Welcome",
            description: "Are you ready to discover your favorite movies and TV shows? We've got some great recommendations for you!",
            icon: "movieclapper",
            iconColor: .red
        ),
        OnboardingData(
            title: "Explore!",
            description: "Discover new favorites with trailers of movies and TV shows. Create your watchlist!",
            icon: "tv.fill",
            iconColor: .purple
        ),
        OnboardingData(
            title: "Learn the Details!",
            description: "Actors, summaries, and interesting facts. Dive into the background of every production!",
            icon: "popcorn.fill",
            iconColor: .blue
        ),
        OnboardingData(
            title: "Easy to Use!",
            description: "Access all the details of movies and TV shows with a single tap. Explore the world from your screen!",
            icon: "hand.tap.fill",
            iconColor: .green
        )
    ]

    var body: some View {
        VStack {
            TabView(selection: $sectionIndex) {
                ForEach(Array(onboardingItems.enumerated()), id: \.element.id) { index, item in
                    OnboardingItem(
                        title: item.title,
                        description: item.description,
                        icon: item.icon,
                        iconColor: item.iconColor
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            VStack {
                if sectionIndex < 3 {
                    Button(action: {
                        withAnimation { // geçişi animasyonlu yapmak için withAnimation kullanıyoruz
                            sectionIndex += 1
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("Continue")
                                .font(.headline)
                                .padding()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(.tertiarySystemBackground))
                        .foregroundColor(Color(.label))
                        .cornerRadius(15)
                        .padding()
                    }

                } else {
                    NavigationLink {
                        TabNavigationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Finish")
                                .font(.headline)
                                .padding()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(.tertiarySystemBackground))
                        .foregroundColor(Color(.label))
                        .cornerRadius(15)
                        .padding()
                    }
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct OnboardingItem: View {
    var title: String
    var description: String
    var icon: String
    var iconColor: Color

    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .bold()
            Text(description)
                .font(.subheadline)
                .multilineTextAlignment(.center)

            Spacer()

            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .foregroundColor(iconColor)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(20)

            Spacer()
        }
        .padding()
    }
}
