//
//  MainButton.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 15.09.2024.
//

import SwiftUI

struct MainButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(15)
        }
    }
}
