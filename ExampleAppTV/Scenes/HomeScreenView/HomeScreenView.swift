//
//  HomeScreenView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 26.06.2024.
//

import SwiftUI
import OSLog

struct HomeScreenView: View {

    let imagesNewForYou = (1...7).map { "image\($0)" }
    let imagesTopAlbum = (8...14).map { "image\($0)" }
    let imagesTopSongs = (15...20).map { "image\($0)" }

    let gridItems = [GridItem(.fixed(100))]
    
    @State private var showMusicPlayer = false

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {

                Text("newForYou.Title")
                    .modifier(HeadlineModifier())
                    .padding(.leading, 50)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridItems, spacing: 0) {
                        ForEach(imagesNewForYou, id: \.self) { imageName in
                            newForYou(imageName: imageName)
                        }
                    }
                }

                Text("topAlbums.Title")
                    .modifier(HeadlineModifier())
                    .padding(.leading, 50)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridItems, spacing: 0) {
                        ForEach(imagesTopAlbum, id: \.self) { imageName in
                            topAlbums(imageName: imageName)
                        }
                    }
                }

                Text("top.Songs.Title")
                    .modifier(HeadlineModifier())
                    .padding(.leading, 50)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridItems, spacing: 0) {
                        ForEach(imagesTopSongs, id: \.self) { imageName in
                            VStack {
                                topSongs(imageName: imageName)
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, 150)
        .ignoresSafeArea(.all)
        .background(
                    NavigationLink(destination: MusicPlayerMultiView(expandSheet: .constant(true), animation: Namespace().wrappedValue), isActive: $showMusicPlayer) {
                        EmptyView()
                    }
                    .hidden() // Hide the actual link view
                )
    }

    //MARK: ViewBuilders

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
                }
                .padding(.leading, 50)
    }

    @ViewBuilder
    func topAlbums(imageName: String) -> some View {
        FocusableButton(action: {
            Logger.viewCycle.info("Button pressed Share")
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
        }
        .padding(.leading, 50)
    }

    @ViewBuilder
    func topSongs(imageName: String) -> some View {
        FocusableButton(action: {
            Logger.viewCycle.info("Button pressed Share")
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
        }
        .padding(.leading, 50)
    }
}

#Preview {
    HomeScreenView()
}

