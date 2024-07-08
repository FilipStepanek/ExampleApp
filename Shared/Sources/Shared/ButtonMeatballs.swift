//
//  ButtonMeatballs.swift
//  ExampleApp
//
//  Created by Filip Štěpánek on 20.06.2024.
//

import SwiftUI

public struct ContentViewButton: View {
    public let title: String
    public let icon: String
    public let action: () -> Void // Action closure
    
    public var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 14.0, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 14.0, weight: .semibold, design: .default))
            }
        }
    }
}

public struct MenuRow: Identifiable, Hashable {
    public let id = UUID()
    public var title: String
    public var icon: String
}

public struct MenuSection: Identifiable, Hashable {
    public let id = UUID()
    public let rows: [MenuRow]
}

@ViewBuilder
public func ButtonMeatballs() -> some View {
    let elements: [MenuSection] = [
        MenuSection(rows: [
            MenuRow(title: "View Credits", icon: "info.circle"),
        ]),
        MenuSection(rows: [
            MenuRow(title: "Add to Library", icon: "plus"),
            MenuRow(title: "Add to a Playlist...", icon: "rectangle.stack.badge.plus")
        ]),
        MenuSection(rows: [
            MenuRow(title: "Share Song...", icon: "square.and.arrow.up"),
            MenuRow(title: "Share Lyrics...", icon: "shared.with.you.circle"),
            MenuRow(title: "Go to Album", icon: "music.note"),
            MenuRow(title: "Create Station", icon: "badge.plus.radiowaves.right")
        ]),
        MenuSection(rows: [
            MenuRow(title: "Favorites", icon: "star"),
            MenuRow(title: "Suggest Less", icon: "hand.thumbsdown")
        ])
    ]
    
    Menu {
        ForEach(elements.reversed(), id: \.self) { section in
            Section {
                ForEach(section.rows.reversed()) { row in
                    ContentViewButton(title: row.title, icon: row.icon) {
                        // Handle button action
                        handleButtonAction(title: row.title)
                    }
                }
            }
        }
    } label: {
        Image(systemName: "ellipsis")
            .foregroundColor(.white)
            .padding(12)
            .background(
                Circle()
                    .fill(Color.gray.opacity(0.2)) // Adjusted to use a specific color
            )
    }
}

public func handleButtonAction(title: String) {
    switch title {
    case "View Credits":
        print("View Credits button pressed")
        // Perform action for View Credits
    case "Add to Library":
        print("Add to Library button pressed")
        // Perform action for Add to Library
    case "Add to a Playlist...":
        print("Add to Playlist button pressed")
        // Perform action for Add to Playlist
    case "Share Song...":
        print("Share Song button pressed")
        // Perform action for Share Song
    case "Share Lyrics...":
        print("Share Lyrics button pressed")
        // Perform action for Share Lyrics
    case "Go to Album":
        print("Go to Album button pressed")
        // Perform action for Go to Album
    case "Create Station":
        print("Create Station button pressed")
        // Perform action for Create Station
    case "Favorites":
        print("Favorites button pressed")
        // Perform action for Favorites
    case "Suggest Less":
        print("Suggest Less button pressed")
        // Perform action for Suggest Less
    default:
        break
    }
}


