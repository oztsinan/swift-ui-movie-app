//
//  TabView.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 15.09.2024.
//

import SwiftUI

struct TabNavigationView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)
        }
    }
}

#Preview {
    TabNavigationView()
}
