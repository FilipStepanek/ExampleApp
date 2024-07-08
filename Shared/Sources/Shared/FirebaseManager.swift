//
//  FirebaseManager.swift
//  ExampleApp
//
//  Created by Filip Štěpánek on 20.06.2024.
//

//import Foundation
//import FirebaseStorage
//import AVFoundation
//
//public class FirebaseManager {
//    
//    public static let shared = FirebaseManager() // Singleton instance
//    
//    private let storage = Storage.storage()
//    private var player: AVAudioPlayer?
//    private var currentVolume: Float = 1.0
//    private var isPlaying = false
//    private var totalTime: TimeInterval = 0.0
//    
//    private init() {}
//    
//    public func fetchImageURL(completion: @escaping (URL?) -> Void) {
//        let imageRef = storage.reference(forURL: "gs://exampleapp-49b6f.appspot.com/sounds/images/oceanWaveWash.jpg")
//        
//        imageRef.downloadURL { (url, error) in
//            if let error = error {
//                print("Error fetching image URL: \(error.localizedDescription)")
//                completion(nil)
//            } else {
//                completion(url)
//            }
//        }
//    }
//    
//    public func fetchAudioURL(completion: @escaping (URL?) -> Void) {
//        let audioRef = storage.reference(forURL: "gs://exampleapp-49b6f.appspot.com/sounds/audio/oceanWaveWash.wav")
//        
//        // Create a reference to a local file
//        let localFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("ocean.wav")
//        
//        // Start downloading
//        let downloadTask = audioRef.write(toFile: localFile) { url, error in
//            if let error = error {
//                print("Error downloading audio file: \(error.localizedDescription)")
//                completion(nil)
//            } else {
//                print("Download completed: \(localFile)")
//                completion(url)
//            }
//        }
//        
//        // Observe the download progress
//        downloadTask.observe(.progress) { snapshot in
//            guard let progress = snapshot.progress else { return }
//            
//            // Calculate percentage downloaded
//            let percentComplete = 100.0 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
//            print("Download progress: \(percentComplete)%")
//            
//            // Start playback when at least half of the file is downloaded
//            if percentComplete >= 70.0 {
//                self.startPlaybackIfReady(localFile: localFile, completion: completion)
//            }
//        }
//        
//        // Handle success, failure, and other states
//        downloadTask.observe(.success) { snapshot in
//            print("Download success")
//        }
//        
//        downloadTask.observe(.failure) { snapshot in
//            if let error = snapshot.error {
//                print("Download failed: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }
//    }
//    
//    private func startPlaybackIfReady(localFile: URL, completion: @escaping (URL?) -> Void) {
//        // Check if audio player is already initialized and playable
//        guard player == nil else { return }
//        
//        // Initialize audio player
//        do {
//            player = try AVAudioPlayer(contentsOf: localFile)
//            player?.prepareToPlay()
//            totalTime = player?.duration ?? 0.0
//            player?.volume = currentVolume
//            
//            // Start playback
//            player?.play()
//            isPlaying = true
//            
//            // Provide completion with the URL
//            completion(localFile)
//        } catch {
//            print("Error loading audio: \(error.localizedDescription)")
//            completion(nil)
//        }
//    }
//}

import Foundation
import FirebaseStorage
import AVFoundation
import OSLog

public class FirebaseManager {
    
    private let networkManager = Network.shared
    public static let shared = FirebaseManager() // Singleton instance
    
    private let storage = Storage.storage()
    private var player: AVAudioPlayer?
    private var currentVolume: Float = 1.0
    private var isPlaying = false
    private var totalTime: TimeInterval = 0.0
    
    public init() {}
    
    public func fetchAudioURLs() async throws -> [URL] {
        let router = RouterFirebaseManager.fetchAudioURLs
        do {
            return try await fetchURLs(using: router)
        } catch {
            Logger.networking.error("Failed to fetch audio URLs: \(error.localizedDescription)")
            throw networkManager.handleNetworkError(error)
        }
    }

    public func fetchImageURLs() async throws -> [URL] {
        let router = RouterFirebaseManager.fetchImageURLs
        do {
            return try await fetchURLs(using: router)
        } catch {
            Logger.networking.error("Failed to fetch image URLs: \(error.localizedDescription)")
            throw networkManager.handleNetworkError(error)
        }
    }

    private func fetchURLs(using router: RouterFirebaseManager) async throws -> [URL] {
        let storageRef = storage.reference().child(router.path)
        let result = try await storageRef.listAll()

        var urls: [URL] = []
        for item in result.items {
            let url = try await item.downloadURL()
            urls.append(url)
        }
        return urls
    }
    
    // Download audio file and observe progress
    private func downloadAudioFile(from url: URL, completion: @escaping ([URL]?) -> Void) {
        let audioRef = storage.reference(forURL: url.absoluteString)
        
        // Create a reference to a local file
        let localFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(audioRef.name)
        
        // Start downloading
        let downloadTask = audioRef.write(toFile: localFile) { url, error in
            if let error = error {
                print("Error downloading audio file: \(error.localizedDescription)")
                completion(nil)
            } else {
                print("Download completed: \(localFile)")
                completion([localFile])
            }
        }
        
        // Observe the download progress
        downloadTask.observe(.progress) { snapshot in
            guard let progress = snapshot.progress else { return }
            
            // Calculate percentage downloaded
            let percentComplete = 100.0 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
            print("Download progress: \(percentComplete)%")
            
            // Start playback when at least half of the file is downloaded
            if percentComplete >= 70.0 {
                self.startPlaybackIfReady(localFile: localFile, completion: completion)
            }
        }
        
        // Handle success, failure, and other states
        downloadTask.observe(.success) { snapshot in
            print("Download success")
        }
        
        downloadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                print("Download failed: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    private func startPlaybackIfReady(localFile: URL, completion: @escaping ([URL]?) -> Void) {
        // Check if audio player is already initialized and playable
        guard player == nil else { return }
        
        // Initialize audio player
        do {
            player = try AVAudioPlayer(contentsOf: localFile)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
            player?.volume = currentVolume
            
            // Start playback
            player?.play()
            isPlaying = true
            
            // Provide completion with the URL
            completion([localFile])
        } catch {
            print("Error loading audio: \(error.localizedDescription)")
            completion(nil)
        }
    }
}

