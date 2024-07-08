//
//  SearchScreenView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 03.07.2024.
//

import SwiftUI

struct SearchScreenView: View {
    @State private var searchText = ""
    
    private let artists = [
        "P!nk", "Imagine Dragons", "Taylor Swift", "Madonna", "Hanz Zimmer", "MIKA"
    ]
    
    private var searchResults: [String] {
        searchText.isEmpty ? artists : artists.filter { $0.contains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(searchResults, id: \.self) { artist in
                    Text(artist)
                        .foregroundColor(.white) // Set the font color to white
                }
            }
            .searchable(text: $searchText)
            .foregroundColor(.white)
        }
        .preferredColorScheme(.dark)
    }
}

#if DEBUG
#Preview {
    SearchScreenView()
}
#endif
