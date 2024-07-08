//
//  YourLibrary.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 03.07.2024.
//

import SwiftUI
import OSLog

struct YourLibraryView: View {

    let imagesLibrary = (1...20).map { "image\($0)" }

    let gridItems = [
        GridItem(.fixed(400), spacing: 50),
        GridItem(.fixed(400), spacing: 50),
        GridItem(.fixed(400), spacing: 50),
        GridItem(.fixed(400))
    ]
    
    @State private var showMusicPlayer = false

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(imagesLibrary, id: \.self) { imageName in
                        newForYou(imageName: imageName)
                    }
                }
            }
            .padding(.top, 150)
            .ignoresSafeArea(.all)
            .background(
                EmptyView()
                    .hidden()
                    .navigationDestination(isPresented: $showMusicPlayer) {
                        MusicPlayerMultiView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
                    }
            )
        }
    }

    // MARK: ViewBuilders

    @ViewBuilder
    func newForYou(imageName: String) -> some View {
        FocusableButton(action: {
            Logger.viewCycle.info("Button pressed Share")
            showMusicPlayer = true
        }) {
            VStack(spacing: 10) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                
                Text("Song Name")
                    .modifier(SoundtrackModifier())
                    .padding(.top)
                Text("Artist")
                    .modifier(ArtistModifier())
            }
            .buttonStyle(.card)
        }
        .padding()
    }
}

#Preview {
    YourLibraryView()
}
