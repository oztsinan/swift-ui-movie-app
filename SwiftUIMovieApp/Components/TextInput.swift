//
//  TextInput.swift
//  SwiftUIMovieApp
//
//  Created by Sinan Öztürk on 15.09.2024.
//

import SwiftUI

struct TextInput: View {
    @Binding var value: String
    var placeholder: String

    var body: some View {
        TextField(
            placeholder,
            text: $value
        )
        .disableAutocorrection(true)
        .frame(maxHeight: 50)
        .padding(.horizontal)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(UIColor.separator))
        }
    }
}
