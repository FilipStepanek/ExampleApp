//
//  MusicPlayerMultiView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 02.07.2024.
//

import SwiftUI
import SDWebImageSwiftUI
import AVFoundation
import Shared
import OSLog

struct MusicPlayerMultiView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject private var viewModel = MusicPlayerViewModel()
    @Binding var expandSheet: Bool
    
    var animation: Namespace.ID
    let paddingValue: CGFloat = 25
    @State private var animationContent: Bool = false
    
    let images = (1...20).map { "image\($0)" }
    let gridItems = [GridItem(.fixed(700))]
    
    let placeholderImage = "placeholderImage"
    
    // TODO: Combine MusicPlayerSingl and Multi to one with concurency by the playlist
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                
                BackgroundPlayerView()
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: gridItems, spacing: 30) {
                            Color.clear
                                .frame(width: 525, height: 700)
                                .padding(.trailing, 15)
                            
                            
                            ForEach(images.indices, id: \.self) { index in
                                soundCarusell(imageName: images[index])
                                    .containerRelativeFrame(.horizontal,  count: 3, spacing: 0)
                                    .scrollTransition { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1.0 : 0.5)
                                            .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3, y: phase.isIdentity ? 1.0 : 0.3)
                                            .offset(y: phase.isIdentity ? 0 : 50)
                                    }
                            }
                        }
//                        .background(.blue)
                        .scrollTargetLayout()
                        
                    }
                    .scrollTargetLayout()
                    .contentMargins(16, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                    
                    PlayerView(viewModel: viewModel)
//                        .background(.red)
                    
                }
                .padding(.top, 30)
                .padding(.bottom, 40)
            }
        }
    }
    
    
    @ViewBuilder
    func soundCarusell(imageName: String) -> some View {
        FocusableButton(action: {
            Logger.viewCycle.info("Button pressed Share")
        }) {
            VStack(spacing: 10) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 525)
                
                
                Text("Song Name")
                    .modifier(SoundtrackModifier())
                    .padding(.top)
                Text("Artist")
                    .modifier(ArtistModifier())
            }
        }
    }
}

struct PlayerView: View {
    @ObservedObject var viewModel: MusicPlayerViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                ButtonMeatballs()
            }
            
            PlayerSlider(value: Binding(
                get: { viewModel.currentTime.seconds },
                set: { newTime in
                    let time = CMTime(seconds: newTime, preferredTimescale: 1)
                    viewModel.seek(to: time)
                }
            ), range: 0...viewModel.totalTime.seconds) { newPosition in
                let time = CMTime(seconds: newPosition, preferredTimescale: 1)
                viewModel.seek(to: time)
            }
            
            HStack {
                Text(viewModel.timeString(from: viewModel.currentTime))
                Spacer()
                Text(viewModel.timeString(from: viewModel.totalTime))
            }
            .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, 50)
    }
}

struct MusicPlayerMultiView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerMultiView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
            .preferredColorScheme(.dark)
    }
}


