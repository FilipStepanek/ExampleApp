//
//  MusicPlayerViewModel.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 25.06.2024.
//

import SwiftUI
import AVFoundation
import MediaPlayer
import Combine
import SDWebImageSwiftUI
import Shared

class MusicPlayerViewModel: ObservableObject {
    @Published var imageURL: URL?
    @Published var audioURL: URL?
    @Published var player: AVPlayer?
    @Published var isPlaying = false
    @Published var currentTime: CMTime = .zero
    @Published var totalTime: CMTime = .zero
    @Published var currentVolume: Float = 1.0
    @Published var isBuffering = false
    
    private var playerItem: AVPlayerItem?
    private var cancellables = Set<AnyCancellable>()
    private var timeObserverToken: Any?
    
//    init() {
//        fetchFirebaseData()
//        setupRemoteCommandCenter()
//    }
    
    deinit {
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
        }
    }
//    
//    func fetchFirebaseData() {
//        FirebaseManager.shared.fetchImageURL { [weak self] url in
//            self?.imageURL = url
//        }
//        
//        FirebaseManager.shared.fetchAudioURL { [weak self] url in
//            self?.audioURL = url
//            if let audioURL = url {
//                self?.setupAudio(url: audioURL)
//            }
//        }
//    }
    
    private func setupAudio(url: URL) {
        let asset = AVAsset(url: url)
        playerItem = AVPlayerItem(asset: asset)
        playerItem?.preferredForwardBufferDuration = 10
        player = AVPlayer(playerItem: playerItem)
        player?.volume = currentVolume
        
        playerItem?.publisher(for: \.status)
            .sink { [weak self] status in
                if status == .readyToPlay {
                    self?.totalTime = self?.playerItem?.asset.duration ?? .zero
                    self?.play()
                } else if status == .failed {
                    print("Player item failed to load")
                }
            }
            .store(in: &cancellables)
        
        playerItem?.publisher(for: \.isPlaybackLikelyToKeepUp)
            .sink { [weak self] isPlaybackLikelyToKeepUp in
                self?.isBuffering = !isPlaybackLikelyToKeepUp
            }
            .store(in: &cancellables)
        
        playerItem?.publisher(for: \.isPlaybackBufferFull)
            .sink { [weak self] isPlaybackBufferFull in
                self?.isBuffering = !isPlaybackBufferFull
            }
            .store(in: &cancellables)
        
        addPeriodicTimeObserver()
    }
    
    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTime = time
            if let duration = self?.player?.currentItem?.duration {
                self?.totalTime = duration
            }
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func seek(to time: CMTime) {
        player?.seek(to: time)
    }
    
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [unowned self] _ in
            self.play()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [unowned self] _ in
            self.pause()
            return .success
        }
        
        commandCenter.togglePlayPauseCommand.addTarget { [unowned self] _ in
            if self.isPlaying {
                self.pause()
            } else {
                self.play()
            }
            return .success
        }
        
        commandCenter.seekForwardCommand.addTarget { [unowned self] _ in
            let newTime = CMTimeGetSeconds(self.currentTime) + 10
            self.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
            return .success
        }
        
        commandCenter.seekBackwardCommand.addTarget { [unowned self] _ in
            let newTime = CMTimeGetSeconds(self.currentTime) - 10
            self.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
            return .success
        }
    }
    
    func timeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
