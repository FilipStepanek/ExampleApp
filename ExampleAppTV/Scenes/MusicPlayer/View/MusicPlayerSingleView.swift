//
//  MusicPlayerView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 21.06.2024.
//

import SwiftUI
import SDWebImageSwiftUI
import AVFoundation
import Shared
import OSLog

struct MusicPlayerSingleView: View {
    
    @StateObject private var viewModel = MusicPlayerViewModel()
    @Binding var expandSheet: Bool
    
    let paddingValue: CGFloat = 25
    
    var body: some View {
            ZStack {
                
                BackgroundPlayerView()
                
                VStack {
                        singlPlayer(imageName: "image3")
                        
                        
                        SinglPlayerView(viewModel: viewModel)
//                        .background(.red)
                        
                    }
                    .padding(.top, 80)
                    .padding(.bottom, 50)
                }
    }
    
    @ViewBuilder
    func singlPlayer(imageName: String) -> some View {
        FocusableButton(action: {
            Logger.viewCycle.info("Button pressed Share")
        }) {
            VStack(spacing: 10) {
                Image(.image6)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 650, height: 650)
                
                
                Text("Song Name")
                    .modifier(SoundtrackModifier())
                    .padding(.top)
                Text("Artist")
                    .modifier(ArtistModifier())
            }
        }
    }
}

struct SinglPlayerView: View {
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
    }
}

struct MusicPlayerSingleView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerSingleView(expandSheet: .constant(true))
            .preferredColorScheme(.dark)
    }
}

