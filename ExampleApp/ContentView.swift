//
//  ContentView.swift
//  ExampleApp
//
//  Created by Filip Štěpánek on 20.06.2024.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI
import Combine
import Shared

struct ContentView: View {
    
    @State private var imageURL: URL?
    @State private var audioURL: URL?
    @State private var player: AVPlayer?
    @State private var playerItem: AVPlayerItem?
    @State private var isPlaying = false
    @State private var totalTime: CMTime = .zero
    @State private var currentTime: CMTime = .zero
    @State private var currentVolume: Float = 1.0
    @State private var cancellables = Set<AnyCancellable>()
    @State private var isBuffering = false
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    let paddingValue: CGFloat = 25
    @State private var animationContent: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        Group {
                            if let imageURL = imageURL {
                                WebImage(url: imageURL)
                                    .resizable()
                                    .ignoresSafeArea()
                                    .blur(radius: 55)
                            } else {
                                Image(.default)
                                    .blur(radius: 55)
                            }
                        }
                    )
                
                VStack {
                    VStack(spacing: 15) {
                        Group {
                            if let imageURL = imageURL {
                                WebImage(url: imageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width - 2 * paddingValue, height: geometry.size.width - 2 * paddingValue)
                                    .cornerRadius(15)
                            } else {
                                Image("red")
                                    .blur(radius: 55)
                            }
                        }
                        
                        PlayerView()
                        
                        PlayPauseControl()
                        
                        VolumeSlider()
                        
                        BottomControl() 
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 20)
                    .padding(.horizontal, paddingValue)
                }
            }
            .onAppear {
                fetchFirebaseData()
            }
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                updateProgress()
            }
        }
    }
    
    private func fetchFirebaseData() {
        FirebaseManager.shared.fetchImageURL { url in
            self.imageURL = url
        }
        
        FirebaseManager.shared.fetchAudioURL { url in
            self.audioURL = url
            if let audioURL = url {
                setupAudio(url: audioURL)
            }
        }
    }
    
    private func setupAudio(url: URL) {
        let asset = AVAsset(url: url)
        
        let assetDuration = asset.duration.seconds
        
        // Check if asset duration is valid
        guard !assetDuration.isNaN else {
            print("Asset duration is not valid")
            return
        }
        
        // Initialize player item
        playerItem = AVPlayerItem(asset: asset)
        playerItem?.preferredForwardBufferDuration = 10 // Adjust buffer duration as needed
        player = AVPlayer(playerItem: playerItem)
        player?.volume = currentVolume
        
        // Observe playerItem status and buffering state
        playerItem?.publisher(for: \.status)
            .sink { status in
                if status == .readyToPlay {
                    // Ensure totalTime is set correctly
                    if let item = self.playerItem {
                        self.totalTime = item.asset.duration
                    }
                    self.playAudio() // Start playing once ready
                } else if status == .failed {
                    print("Player item failed to load")
                    // Handle failure
                }
            }
            .store(in: &cancellables) // Store in cancellables set
        
        playerItem?.publisher(for: \.isPlaybackLikelyToKeepUp)
            .sink { isPlaybackLikelyToKeepUp in
                self.isBuffering = !isPlaybackLikelyToKeepUp
            }
            .store(in: &cancellables) // Store in cancellables set
        
        playerItem?.publisher(for: \.isPlaybackBufferFull)
            .sink { isPlaybackBufferFull in
                self.isBuffering = !isPlaybackBufferFull
            }
            .store(in: &cancellables) // Store in cancellables set
    }
    
    private func playAudio() {
        player?.play()
        isPlaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime()
    }
    
    private func seekAudio(to time: CMTime) {
        player?.seek(to: time)
    }
    
    private func timeString(time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @ViewBuilder
    func PlayPauseControl() -> some View { // Corrected function name
        let buttonSize: CGFloat = 50
        
        HStack(spacing: 30) {
            Button(action: {
                seekAudio(to: max(CMTime.zero, CMTimeSubtract(currentTime, CMTimeMakeWithSeconds(10, preferredTimescale: 1)))) // 10 seconds backward
            }) {
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
            }
            
            Button(action: {
                if isPlaying {
                    stopAudio()
                } else {
                    playAudio()
                }
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: buttonSize))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: buttonSize * 1.5, height: buttonSize * 1.5)
            }
            
            Button(action: {
                seekAudio(to: min(totalTime, CMTimeAdd(currentTime, CMTimeMakeWithSeconds(10, preferredTimescale: 1)))) // 10 seconds forward
            }) {
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
    @ViewBuilder
    func VolumeSlider() -> some View {
        HStack {
            Image(systemName: "speaker.fill")
                .foregroundColor(.white)
            
            Slider(value: $currentVolume, in: 0.0...1.0)
                .foregroundColor(.white)
                .onChange(of: currentVolume) { newValue in
                    player?.volume = newValue
                }
                .accentColor(.white)
            
            Image(systemName: "speaker.wave.3.fill")
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    func BottomControl() -> some View {
        HStack(alignment: .top, spacing: 90) {
            Button {
                // TODO: Add action
            } label: {
                Image(systemName: "quote.bubble")
                    .font(.title2)
            }
            
            VStack(spacing: 6) {
                Button {
                    // TODO: Add action
                } label: {
                    Image(systemName: "airpodspro.chargingcase.wireless.fill")
                        .font(.title2)
                }
                
                Text("Song Airpods")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Button {
                // TODO: Add action
            } label: {
                Image(systemName: "list.bullet")
                    .font(.title2)
            }
        }
        .foregroundColor(.white)
        .blendMode(.overlay)
        .padding(.top)
    }
    
    @ViewBuilder
    func PlayerView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sea sound")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Nature")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                ButtonMeatballs()
            }
            
            PlayerSlider(value: Binding(
                get: { CMTimeGetSeconds(currentTime) },
                set: { newTime in
                    let time = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1)
                    seekAudio(to: time)
                }
            ), range: 0...CMTimeGetSeconds(totalTime)) { newPosition in
                let time = CMTimeMakeWithSeconds(newPosition, preferredTimescale: 1)
                seekAudio(to: time)
            }
            
            HStack {
                Text(timeString(time: currentTime))
                Spacer()
                Text(timeString(time: totalTime))
            }
            .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
            .preferredColorScheme(.dark)
    }
}

    
