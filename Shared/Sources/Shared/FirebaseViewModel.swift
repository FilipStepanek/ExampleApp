//
//  FirebaseViewModel.swift
//
//
//  Created by Filip Štěpánek on 26.06.2024.
//

import SwiftUI
import FirebaseDatabase
import OSLog

//MARK: Fetch and store the data from Firebase
public class SoundsViewModel: ObservableObject {
    @Published public var soundsItems: [SoundsItem] = []
    
    private var ref: DatabaseReference!
    
    public init() {
        self.ref = Database.database().reference()
        fetchSoundsItems()
    }
    
    func fetchSoundsItems() {
        ref.child("soundsV1").observe(.value) { snapshot in
            var newItems: [SoundsItem] = []
            Logger.firebaseData.info("Snapshot: \(snapshot)")
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let artist = value["artist"] as? String,
                   let audioPath = value["audioPath"] as? String,
                   let category = value["category"] as? String,
                   let color = value["color"] as? String,
                   let coverImagePath = value["coverImagePath"] as? String,
                   let coverImageUrl = value["coverImageUrl"] as? String,
                   let title = value["title"] as? String {
                    let id = snapshot.key
                    let musicItem = SoundsItem(id: id, artist: artist, audioPath: audioPath, category: category, color: color, coverImagePath: coverImagePath, coverImageUrl: coverImageUrl, title: title)
                    newItems.append(musicItem)
                } else {
                    print("Failed to parse snapshot: \(child)")
                }
            }
            self.soundsItems = newItems
            Logger.firebaseData.info("Fetched items: \(self.soundsItems)")
        }
    }
}

